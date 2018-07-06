//
// RoomsViewController.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit
import Reusable

final class RoomsViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: LoadMoreTableView!
    var viewModel: RoomsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        tableView.do {
            $0.loadMoreDelegate = self
            $0.estimatedRowHeight = 550
            $0.rowHeight = UITableViewAutomaticDimension
            $0.register(cellType: RoomCell.self)
        }
    }

    deinit {
        logDeinit()
    }

    func bindViewModel() {
        let input = RoomsViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.refreshTrigger,
            loadMoreTrigger: tableView.loadMoreTrigger,
            selectRoomTrigger: tableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)
        output.roomList
            .drive(tableView.rx.items) { tableView, index, room in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: RoomCell.self)
                    .then {
                        $0.configView(with: room)
                    }
            }
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(tableView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(tableView.loadingMore)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedRoom
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive()
            .disposed(by: rx.disposeBag)
    }

}

// MARK: - UITableViewDelegate
extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension RoomsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home.instance
}
