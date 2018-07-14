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
    // MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel: RoomsViewModel!
    
    fileprivate var sectionInsets: UIEdgeInsets!
    fileprivate var screenSize = UIScreen.main.bounds.size
    
    // MARK: - Binding

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        title = "rooms.navigation.title".localized()
        
        collectionView.do {
            $0.register(cellType: RoomCell.self)
            $0.alwaysBounceVertical = true
        }
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        sectionInsets = isIPad()
            ? UIEdgeInsets(top: 25.0, left: 147.0, bottom: 44.0, right: 152)
            : UIEdgeInsets(top: 25.0, left: 10, bottom: 30.0, right: 10)
    }

    deinit {
        logDeinit()
    }
    
    // MARK: BindViewModel
    func bindViewModel() {
        
        let input = RoomsViewModel.Input(
            loadTrigger: Driver.just(()),
            addRoomTrigger: addButton.rx.tap.asDriver(),
            selectRoomTrigger: collectionView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)
        output.roomList
            .drive(collectionView.rx.items) { collectionView, index, room in
                return collectionView.dequeueReusableCell(
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
        output.selectedRoom
            .drive()
            .disposed(by: rx.disposeBag)
        output.addRoom
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: Private Methods
    
}

// MARK: - UITableViewDelegate
extension RoomsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow = 4
        let spaceBetweenCell = isIPad() ? 30 : 20 //12 : 8
        let paddingSpace: CGFloat = sectionInsets.left + sectionInsets.right + CGFloat((itemsPerRow - 1) * spaceBetweenCell)
        let availableWidth = screenSize.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        let heightPerItem = widthPerItem
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - StoryboardSceneBased
extension RoomsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home.instance
}
