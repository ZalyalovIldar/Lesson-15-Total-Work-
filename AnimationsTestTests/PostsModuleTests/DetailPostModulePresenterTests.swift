//
//  DetailPostPresenterTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class DetailPostModulePresenterTests: XCTestCase {

    var presenter: DetailPostModulePresenter!
    var router: DetailPostModuleRouterMock!
    var interactor: DetailPostModuleInteractorMock!
    
    override func setUpWithError() throws {
        
        presenter = DetailPostModulePresenter()
        router = DetailPostModuleRouterMock()
        interactor = DetailPostModuleInteractorMock()
        
        presenter.interactor = interactor
        presenter.router = router
    }

    override func tearDownWithError() throws {
        
        presenter = nil
        interactor = nil
        router = nil
    }

    func testPressingSaveButtonWithNoChanges() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        let delegate = PostsModuleViewController()
        
        presenter.didPressSaveButton(on: testPost, isChanged: false, delegate: delegate)
        
        XCTAssertTrue(router.isEndingEditing)
    }
    
    func testPressingSaveButtonWithChanges() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        let delegate = PostsModuleViewController()
        
        presenter.didPressSaveButton(on: testPost, isChanged: true, delegate: delegate)
        
        XCTAssertTrue(interactor.isSavingChanges)
    }
    
    func testFinishingEditingAfterSavingChanges() throws {
        
        let delegate = PostsModuleViewController()
        
        presenter.didFinishSavingChanges(delegate: delegate)
        
        XCTAssertTrue(router.isEndingEditingWithUpdate)
    }
}
