//
//  PresenterTests.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 01.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class PresenterTests: XCTestCase {
    
    var view: ViewMock!
    var presenter: MainPresenter!
    var interactor: InteractorMock!
    var router: RouterMock!
    var dataSource: DataSourceMock!

    override func setUpWithError() throws {
        
        view = ViewMock()
        presenter = MainPresenter()
        interactor = InteractorMock()
        router = RouterMock()
        dataSource = DataSourceMock()
                
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.dataSource = dataSource
        
        interactor.presenter = presenter
        
        view.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldCompletelyRefreshDataAfteDataIsFetched() throws {
        
        presenter.didFinishFetchingHeroes(result: [])
        XCTAssertTrue(view.dataShouldBeCompletelyReloaded)
    }
    
    func testRouterShouldDisplayErrorAlertWhenErrorOccurs() throws {
        
        presenter.didFinishFetchingHeroes(with: NSError(domain: String(), code: 1, userInfo: .none))
        XCTAssertTrue(router.shouldDisplayErrorAlert)
    }
    
    func testViewShouldReloadDataOnDeletionsWhenNotificationWithDeletionsReceived() throws {
        
        presenter.didReceiveUpdateNotification(new: [], deletions: [.zero], insertions: [], modifications: [])
        XCTAssertTrue(view.shouldUpdateTableViewWithDeletions)
    }
    
    func testViewShouldInsertDataOnInsertionsWhenNotificationWithInsertionsReceived() throws {
        
        presenter.didReceiveUpdateNotification(new: [], deletions: [], insertions: [.zero], modifications: [])
        XCTAssertTrue(view.shouldUpdateTableViewWithInsertions)
    }
    
    func testViewShouldReloadDataOnModificationsWhenNotificationWithModificationsReceived() throws {
        
        presenter.didReceiveUpdateNotification(new: [], deletions: [], insertions: [], modifications: [.zero])
        XCTAssertTrue(view.shouldUpdateTableViewWithModifications)
    }
    
    func testViewShouldDisplayLoadingViewImmediatelyAfterViewDidLoad() throws {
        
        presenter.viewDidLoad()
        XCTAssertTrue(view.shouldDisplayLoadingView)
    }
    
    func testViewShouldRegisterDataSourceAfterViewDidLoad() throws {
        
        presenter.viewDidLoad()
        XCTAssertTrue(view.shouldConnectDataSource)
    }
    
    func testInteractorShouldFetchAllHeroesAfterViewDidLoad() throws {
        
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.shouldFetchAllHeroes)
    }
    
    func testInteractorShouldPerformDeleteOnDidPressedDelete() throws {
        
        presenter.didPressedDelete(on: IndexPath(item: .zero, section: .zero))
        XCTAssertTrue(interactor.shouldPerformDelete)
    }
    
    func testInteractorShouldPerformRenameOnDidPressedRename() throws {
        
        presenter.didPressedRename(on: IndexPath(item: .zero, section: .zero))
        XCTAssertTrue(router.shouldDisplayRenamingAlert)
    }
    
    func testViewShouldDisplayDetailViewAfterRowWasSelected() throws {
        
        presenter.didSelectRow(at: IndexPath(item: .zero, section: .zero))
        XCTAssertTrue(view.shouldDisplayDetailView)
    }
    
    func testViewShouldDisplayDetailViewAsCardAfterLongPress() throws {
        
        presenter.didLongPressedOnCell(at: IndexPath(item: .zero, section: .zero))
        XCTAssertTrue(view.shouldDisplatDetailViewAsCard)
    }
    
    func testViewShouldFireHapticImpactAtLongPress() throws {
        
        presenter.didLongPressedOnCell(at: IndexPath(item: .zero, section: .zero))
        XCTAssertTrue(view.shouldFireHapticImpact)
    }
    
    func testViewShouldUpdatePanAnimationPercentage() throws {
        
        presenter.updatePanAnimationPercentage(with: .zero)
        XCTAssertTrue(view.viewShouldUpdatePanAnimationPercentage)
    }
    
    func testViewShouldFinishPanAnimation() throws {
        
        presenter.finishPanAnimation(at: .zero)
        XCTAssertTrue(view.viewShouldFinishPanAnimation)
    }
    
    func testInteractorShouldPerformRenameAfterUserDidEnterNewName() throws {
        
        presenter.userDidEnterNewName(for: IndexPath(item: .zero, section: .zero), name: String())
        XCTAssertTrue(interactor.shouldPerformRename)
    }
    
    func testInteractorShouldPerformImageSaveAfterImageDidLoad() throws {
        
        presenter.didLoadImage(data: Data(), id: .zero)
        XCTAssertTrue(interactor.shouldSaveImage)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            try! self.setUpWithError()
        }
    }

}
