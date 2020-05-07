//
//  ViewMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit
@testable import AnimationsTest

class ViewMock: MainViewInput {
    
    var shouldDisplayTableView = false
    var shouldDisplayLoadingView = false
    var dataShouldBeCompletelyReloaded = false
    var shouldUpdateTableViewWithDeletions = false
    var shouldUpdateTableViewWithInsertions = false
    var shouldUpdateTableViewWithModifications = false
    var shouldDisplayDetailView = false
    var shouldDisplatDetailViewAsCard = false
    var shouldConnectDataSource = false
    var shouldFireHapticImpact = false
    var viewShouldUpdatePanAnimationPercentage = false
    var viewShouldFinishPanAnimation = false
    
    weak var presenter: MainViewOutput!
    
    func displayTableView() {
        shouldDisplayTableView.toggle()
    }
    
    func displayLoadingView() {
        shouldDisplayLoadingView.toggle()
    }
    
    func reloadData() {
        dataShouldBeCompletelyReloaded.toggle()
    }
    
    func reloadData(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath]) {
        
        if !deletions.isEmpty {
            shouldUpdateTableViewWithDeletions.toggle()
        }
        if !insertions.isEmpty {
            shouldUpdateTableViewWithInsertions.toggle()
        }
        if !modifications.isEmpty {
            shouldUpdateTableViewWithModifications.toggle()
        }
    }
    
    func registerDataSource(_ dataSource: UITableViewDataSource) {
        shouldConnectDataSource.toggle()
    }
    
    func displayDetailView(for hero: HeroDto, at indexPath: IndexPath) {
        shouldDisplayDetailView.toggle()
    }
    
    func displayDetailViewAsCard(for hero: HeroDto, at indexPath: IndexPath) {
        shouldDisplatDetailViewAsCard.toggle()
    }
    
    func updatePanAnimationPercentage(with percentage: Double) {
        viewShouldUpdatePanAnimationPercentage.toggle()
    }
    
    func finishPanAnimation() {
        viewShouldFinishPanAnimation.toggle()
    }
    
    func fireHapticImpact() {
        shouldFireHapticImpact.toggle()
    }
}
