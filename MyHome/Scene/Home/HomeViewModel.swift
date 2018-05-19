//
// HomeViewModel.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

struct HomeViewModel: ViewModelType {

    struct Input {
        let firstLoadTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }

    struct Output {
        let rooms: Driver<[Room]>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let selectedRoom: Driver<Void>
    }

    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let rooms = input.firstLoadTrigger
            .flatMapLatest { (_) -> Driver<[Room]> in
                return self.useCase.getListRoom()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let selectedRoom = input.selection
            .withLatestFrom(rooms) { ($0, $1) }
            .do(onNext: { (indexPath, rooms) in
                let id = rooms[indexPath.row].id
                self.navigator.toRoom(id: id)
            })
            .mapToVoid()
        
        let error = errorTracker.asDriver()
        let loading = activityIndicator.asDriver()
        
        return Output(rooms: rooms,
                      error: error,
                      loading: loading,
                      selectedRoom: selectedRoom)
    }

}

// MARK: - InputBuilder
extension HomeViewModel {
    final class InputBuilder: Then {
        var firstLoadTrigger: Driver<Void> = Driver.empty()
        var selection: Driver<IndexPath> = Driver.empty()
    }
}

extension HomeViewModel.Input {
    init(builder: HomeViewModel.InputBuilder) {
        self.init(firstLoadTrigger: builder.firstLoadTrigger,
                  selection: builder.selection)
    }
}

