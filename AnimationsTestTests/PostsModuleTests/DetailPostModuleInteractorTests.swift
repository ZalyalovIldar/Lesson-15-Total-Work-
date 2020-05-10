//
//  DetailPostInteractorTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class DetailPostModuleInteractorTests: XCTestCase {

    var interactor: DetailPostModuleInteractor!
    var presenter: DetailPostModulePresenterMock!
    var databaseManager: DatabaseManagerMock!
    
    override func setUpWithError() throws {
        
        interactor = DetailPostModuleInteractor()
        presenter = DetailPostModulePresenterMock()
        databaseManager = DatabaseManagerMock()
        
        interactor.presenter = presenter
        interactor.databaseManager = databaseManager
    }

    override func tearDownWithError() throws {
       
        interactor = nil
        presenter = nil
        databaseManager = nil
    }

    func testSavingChangesToDatabase() throws {

        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        let delegate = PostsModuleViewController()
        
        interactor.saveChanges(of: testPost, delegate: delegate)
        
        XCTAssertTrue(databaseManager.isUpdatedPost)
    }
    
    func testFinishingSavingChangesToDatabase() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        let delegate = PostsModuleViewController()
        
        interactor.saveChanges(of: testPost, delegate: delegate)
        
        XCTAssertTrue(presenter.isFinishingSavingChanges)
    }
}
