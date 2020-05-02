//
//  PresenterMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class PresenterMock: MainViewOutput, MainInteractorOutput, MainRouterOutput, MainDataSourceOutput {
    
    var shouldCallViewDidLoad = false
    var shouldCallDidPressedDelete = false
    var shouldCallDidPressedRename = false
    var shouldCallDidSelectRow = false
    var shouldCallDidLongPressedOnCell = false
    var shouldCallUpdatePanAnimationPercentage = false
    var shouldCallFinishPanAnimation = false
    var shouldCallDidFinishFetchingHeroesWithResult = false
    var shouldCallDidFinishFetchingHeroesWithError = false
    var shouldCallDidReceiveUpdateNotification = false
    var shouldCallUserDidEnterNewName = false
    var shouldCallDidLoadImage = false
    
    var router: MainRouterInput!
    var interactor: MainInteractorInput!
    weak var view: MainViewInput!
    var dataSource: MainDataSourceInput!
    
    func viewDidLoad() {
        shouldCallViewDidLoad.toggle()
    }
    
    func didPressedDelete(on indexPath: IndexPath) {
        shouldCallDidPressedDelete.toggle()
    }
    
    func didPressedRename(on indexPath: IndexPath) {
        shouldCallDidPressedRename.toggle()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        shouldCallDidSelectRow.toggle()
    }
    
    func didLongPressedOnCell(at indexPath: IndexPath) {
        shouldCallDidLongPressedOnCell.toggle()
    }
    
    func updatePanAnimationPercentage(with percentage: Double) {
        shouldCallUpdatePanAnimationPercentage.toggle()
    }
    
    func finishPanAnimation(at percentage: Double) {
        shouldCallFinishPanAnimation.toggle()
    }
    
    func didFinishFetchingHeroes(result: [HeroDto]) {
        shouldCallDidFinishFetchingHeroesWithResult.toggle()
    }
    
    func didFinishFetchingHeroes(with error: Error) {
        shouldCallDidFinishFetchingHeroesWithError.toggle()
    }
    
    func didReceiveUpdateNotification(new: [HeroDto], deletions: [Int], insertions: [Int], modifications: [Int]) {
        shouldCallDidReceiveUpdateNotification.toggle()
    }
    
    func userDidEnterNewName(for indexPath: IndexPath, name: String) {
        shouldCallUserDidEnterNewName.toggle()
    }
    
    func didLoadImage(data: Data, id: Int) {
        shouldCallDidLoadImage.toggle()
    }
}
