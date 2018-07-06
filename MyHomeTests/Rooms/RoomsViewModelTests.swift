//
// RoomsViewModelTests.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

@testable import MyHome
import XCTest
import RxSwift
import RxBlocking

final class RoomsViewModelTests: XCTestCase {
    private var viewModel: RoomsViewModel!
    private var navigator: RoomsNavigatorMock!
    private var useCase: RoomsUseCaseMock!
    private var disposeBag: DisposeBag!
    private var input: RoomsViewModel.Input!
    private var output: RoomsViewModel.Output!
    private let loadTrigger = PublishSubject<Void>()
    private let reloadTrigger = PublishSubject<Void>()
    private let loadMoreTrigger = PublishSubject<Void>()
    private let selectRoomTrigger = PublishSubject<IndexPath>()

    override func setUp() {
        super.setUp()
        navigator = RoomsNavigatorMock()
        useCase = RoomsUseCaseMock()
        viewModel = RoomsViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        input = RoomsViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
            selectRoomTrigger: selectRoomTrigger.asDriverOnErrorJustComplete()
        )
        output = viewModel.transform(input)
        output.error.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.roomList.drive().disposed(by: disposeBag)
        output.selectedRoom.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
    }

    func test_loadTriggerInvoked_getRoomList() {
        // act
        loadTrigger.onNext(())
        let roomList = try? output.roomList.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(useCase.getRoomList_Called)
        XCTAssertEqual(roomList??.count, 1)
    }

    func test_loadTriggerInvoked_getRoomList_failedShowError() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        loadTrigger.onNext(())
        getRoomList_ReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRoomList_Called)
        XCTAssert(error is TestError)
    }

    func test_reloadTriggerInvoked_getRoomList() {
        // act
        reloadTrigger.onNext(())
        let roomList = try? output.roomList.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRoomList_Called)
        XCTAssertEqual(roomList??.count, 1)
    }

    func test_reloadTriggerInvoked_getRoomList_failedShowError() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        reloadTrigger.onNext(())
        getRoomList_ReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRoomList_Called)
        XCTAssert(error is TestError)
    }

    func test_reloadTriggerInvoked_notGetRoomListIfStillLoading() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        loadTrigger.onNext(())
        useCase.getRoomList_Called = false
        reloadTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRoomList_Called)
    }

    func test_reloadTriggerInvoked_notGetRoomListIfStillReloading() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        reloadTrigger.onNext(())
        useCase.getRoomList_Called = false
        reloadTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRoomList_Called)
    }

    func test_loadMoreTriggerInvoked_loadMoreRoomList() {
        // act
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let roomList = try? output.roomList.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.loadMoreRoomList_Called)
        XCTAssertEqual(roomList??.count, 2)
    }

    func test_loadMoreTriggerInvoked_loadMoreRoomList_failedShowError() {
        // arrange
        let loadMoreRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.loadMoreRoomList_ReturnValue = loadMoreRoomList_ReturnValue

        // act
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        loadMoreRoomList_ReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.loadMoreRoomList_Called)
        XCTAssert(error is TestError)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreRoomListIfStillLoading() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        loadTrigger.onNext(())
        useCase.getRoomList_Called = false
        loadMoreTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.loadMoreRoomList_Called)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreRoomListIfStillReloading() {
        // arrange
        let getRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.getRoomList_ReturnValue = getRoomList_ReturnValue

        // act
        reloadTrigger.onNext(())
        useCase.getRoomList_Called = false
        loadMoreTrigger.onNext(())
        // assert
        XCTAssertFalse(useCase.loadMoreRoomList_Called)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        // arrange
        let loadMoreRoomList_ReturnValue = PublishSubject<PagingInfo<Room>>()
        useCase.loadMoreRoomList_ReturnValue = loadMoreRoomList_ReturnValue

        // act
        loadMoreTrigger.onNext(())
        useCase.loadMoreRoomList_Called = false
        loadMoreTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.loadMoreRoomList_Called)
    }

    func test_selectRoomTriggerInvoked_toRoomDetail() {
        // act
        loadTrigger.onNext(())
        selectRoomTrigger.onNext(IndexPath(row: 0, section: 0))

        // assert
        XCTAssert(navigator.toRoomDetail_Called)
    }
}

