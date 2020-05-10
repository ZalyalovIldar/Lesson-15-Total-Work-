//
//  PostsModulePresenterTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class PostsModulePresenterTests: XCTestCase {
    
    var presenter: PostsModulePresenter!
    var router: PostsModuleRouterMock!
    var interactor: PostsModuleInteractorMock!
    var view: PostsModuleViewMock!

    override func setUpWithError() throws {
        
        presenter = PostsModulePresenter()
        router = PostsModuleRouterMock()
        interactor = PostsModuleInteractorMock()
        view = PostsModuleViewMock()
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
    }

    override func tearDownWithError() throws {
        
        presenter = nil
        router = nil
        interactor = nil
        view = nil
    }

    func testOpeningEditingViewAfterPressingEditButton() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        
        presenter.editButtonPressed(for: testPost)
        
        XCTAssertTrue(router.isOpenedEditingView)
    }
    
    func testDeletingPostAfterPressingDeleteButton() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        
        presenter.deleteButtonPressed(for: testPost)
        
        XCTAssertTrue(interactor.isDeletedPost)
    }
    
    func testLoadingPosts() throws {
        
        presenter.loadPosts()
        
        XCTAssertTrue(interactor.isLoadedPostsFromDatabase)
    }
    
    func testLoadingPostsFromNetworkWhenNoPostsInDatabase() throws {
        
        presenter.didFinishLoadingPostsFromDatabase(posts: [])
        
        XCTAssertTrue(interactor.isLoadedPostsFromNetwork)
    }
    
    func testSavingPostsToDatabaseAfterConvertingToDto() throws {
        
        presenter.didFinishConvertingPostsToDto(posts: [])
        
        XCTAssertTrue(interactor.isSavedPostsToDatabase)
    }
    
    func testFinishingLoadingPostsWithNoPostsInDatabase() throws {
        
        presenter.didFinishLoadingPostsFromDatabase(posts: [])
        
        XCTAssertFalse(view.isLoadingPostsFinished)
    }
    
    func testFinishingLoadingPostsFromDatabase() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        
        presenter.didFinishLoadingPostsFromDatabase(posts: [testPost])
        
        XCTAssertTrue(view.isLoadingPostsFinished)
    }
    
    func testFinishingLoadingPostsAfterConvertingPostsFromNetwork() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        
        presenter.didFinishConvertingPostsToDto(posts: [testPost])
        
        XCTAssertTrue(view.isLoadingPostsFinished)
    }
    
    func testFinishingDeletingPost() throws {
        
        presenter.didFinishDeletingPost()
        
        XCTAssertTrue(view.isDeletingPostsFinished)
    }
}
