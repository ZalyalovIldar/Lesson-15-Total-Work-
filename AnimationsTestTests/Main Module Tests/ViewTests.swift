//
//  ViewTests.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 07.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class ViewTests: XCTestCase {
    
    var view: MainViewController!
    var dataSource: DataSourceMock!
    var presenter: PresenterMock!

    override func setUpWithError() throws {
        
        view = MainViewController()
        dataSource = DataSourceMock()
        presenter = PresenterMock()
        
        view.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDisplaysTableViewIfItIsAskedForIt() throws {
        
        view.displayTableView()
        
        XCTAssertTrue(view.mainView.subviews.contains(view.mainView.tableView))
    }
    
    func testViewShouldDisplayLoadingViewIfItIsAskedForIt() throws {
        
        view.displayLoadingView()
        XCTAssertTrue(view.mainView.subviews.contains(view.mainView.loadingIndicator))
    }
    
    func testViewShouldRegisterDataSourceForTableView() throws {
        
        view.registerDataSource(dataSource)
        XCTAssertTrue(view.mainView.tableView.dataSource != nil)
    }
    
    func testReloadDataChangesAmountOfCellsIfDataSourceHasChanged() throws {
        
        view.registerDataSource(dataSource)
        
        let old = view.mainView.tableView.visibleCells.count
        
        dataSource.heroes.append(HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String()))
        
        view.reloadData()
        
        let new = view.mainView.tableView.visibleCells.count
        
        XCTAssertTrue(old != new)
    }
    
    
    func testViewShouldAddDetailViewIntoViewHierarchyIfItIsAskedTo() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailView(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        XCTAssertTrue(view.mainView.subviews.contains(view.detailView))
    }
    
    func testViewShouldAddDetailViewToViewHierarchyIfItIsAskedToDisplayItAsCard() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        XCTAssertTrue(view.mainView.subviews.contains(view.detailView))
    }
    
    func testViewShouldUpdateDismissAnimationPercentage() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        let exp = expectation(description: "Should update percentage")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        
        if result == XCTWaiter.Result.timedOut {
            
            let oldBottomPanAnimatorValue = view.animateToDismiss.fractionComplete
            
            view.updatePanAnimationPercentage(with: 0.8)
            
            XCTAssertTrue(view.animateToDismiss.fractionComplete != oldBottomPanAnimatorValue)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testViewShouldUpdateOpeningAnimationPercentage() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        let exp = expectation(description: "Should update percentage")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        
        if result == XCTWaiter.Result.timedOut {
            
            let oldTopPanAnimatorValue = view.animateToFullScreen.fractionComplete
            
            view.updatePanAnimationPercentage(with: -0.8)
            
            XCTAssertTrue(view.animateToFullScreen.fractionComplete != oldTopPanAnimatorValue)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testViewFinishesPanAnimationWithDismissIfSwipedToNearBottom() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        let exp = expectation(description: "Should open card")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        
        if result == XCTWaiter.Result.timedOut {
            
            view.updatePanAnimationPercentage(with: 0.8)
            view.finishPanAnimation()
            
            let dismissExp = expectation(description: "should dismiss")
            
            let dismissResult = XCTWaiter.wait(for: [dismissExp], timeout: 0.5)
            
            if dismissResult == .timedOut {
                
                XCTAssertFalse(view.mainView.subviews.contains(view.detailView))
            }
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testViewFinishesPanAnimationWithFullscreenDetailViewOpenedIfFinishedNearTop() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        let exp = expectation(description: "Should open card")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        
        if result == XCTWaiter.Result.timedOut {
            
            view.updatePanAnimationPercentage(with: -0.8)
            view.finishPanAnimation()
            
            let dismissExp = expectation(description: "should open fullscreen")
            
            let dismissResult = XCTWaiter.wait(for: [dismissExp], timeout: 0.5)
            
            if dismissResult == .timedOut {
                
                XCTAssertTrue(view.detailView.frame == view.mainView.frame)
            }
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testViewFinishesPanAnimationAtCardStateIfFinishedNearCenter() throws {
        
        view.registerDataSource(dataSource)
        view.mainView.tableView.register(cell: MainTableViewCell.self)
        
        let hero = HeroDto(id: .zero, name: String(), image: String(), imageData: nil, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String())
        
        dataSource.heroes.append(hero)
        view.displayDetailViewAsCard(for: hero, at: IndexPath(row: .zero, section: .zero))
        
        let exp = expectation(description: "Should open card")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        
        if result == XCTWaiter.Result.timedOut {
            
            view.updatePanAnimationPercentage(with: 0.1)
            view.finishPanAnimation()
            
            let dismissExp = expectation(description: "should return to card")
            
            let dismissResult = XCTWaiter.wait(for: [dismissExp], timeout: 0.5)
            
            if dismissResult == .timedOut {
                
                if let gestureRecognizers = view.detailView.gestureRecognizers {
                    
                    XCTAssertTrue(gestureRecognizers.contains(view.cardExpandGestureRecognizer))
                }
                else {
                    XCTFail()
                }
            }
        }
        else {
            XCTFail("Delay interrupted")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
