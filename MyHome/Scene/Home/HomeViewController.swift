//
// HomeViewController.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import RxDataSources

final class HomeViewController: UIViewController, BindableType {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    var viewModel: HomeViewModel!

    // MARK: - Private Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func bindViewModel() {
        let builder = HomeViewModel.InputBuilder().then {
            $0.firstLoadTrigger = Driver.just(())
        }
        let input = HomeViewModel.Input(builder: builder)
        let output = viewModel.transform(input)
        
        output.rooms
            .drive(tableView.rx.items(
                cellIdentifier: HomeItemCell.className,
                cellType: HomeItemCell.self)) { _, room, cell in
                    cell.room = room
                }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.selectedRoom
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - Private Methods
    fileprivate func configUI() {
        title = "tab.home".localized()
        
        tableView.do {
            $0.register(cellType: HomeItemCell.self)
            $0.alwaysBounceVertical = true
            $0.delegate = self
            $0.backgroundColor = UIColor(red: 252, green: 251, blue: 254, alpha: 1.0)
        }
        
    }
}

// MARK: - StoryboardSceneBased
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home.instance
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
