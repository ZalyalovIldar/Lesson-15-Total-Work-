//
//  PostsModuleInteractorTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class PostsModuleInteractorTests: XCTestCase {
    
    var interactor: PostsModuleInteractor!
    var presenter: PostsModulePresenterMock!
    var databaseManager: DatabaseManagerMock!
    var networkManager: NetworkManagerMock!

    override func setUpWithError() throws {
        
        interactor = PostsModuleInteractor()
        presenter = PostsModulePresenterMock()
        databaseManager = DatabaseManagerMock()
        networkManager = NetworkManagerMock()
        
        interactor.presenter = presenter
        interactor.databaseManager = databaseManager
        interactor.networkManager = networkManager
    }

    override func tearDownWithError() throws {
        
        interactor = nil
        presenter = nil
        databaseManager = nil
        networkManager = nil
    }

    func testLoadingPostsFromNetwok() throws {
        
        interactor.loadPostsFromNetwork()
        
        XCTAssert(networkManager.isLoadedPostsFromNetwork)
    }
    
    func testLoadingPostsFromDatabase() throws {
        
        interactor.loadPostsFromDatabase()
        
        XCTAssert(databaseManager.isGotPosts)
    }
    
    func testConvertingPostsToDto() throws {
        
        let testPosts = [Post(userId: 0, id: 0, title: "", body: "")]
        
        interactor.convertPostsToDto(posts: testPosts)
        
        XCTAssert(presenter.isFinishingConvertingPostsToDto)
    }
    
    func testSavingPostToDatabase() throws {
        
        let testPosts = [PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")]
        
        interactor.savePostsToDatabase(posts: testPosts)
        
        XCTAssert(databaseManager.isSavedPosts)
    }
    
    func testDeletingPostFromDatabase() throws {
        
        let testPost = PostDto(userId: 0, id: 0, title: "", body: "", imageUrl: "")
        
        interactor.deletePost(post: testPost)
        
        XCTAssert(databaseManager.isDeletedPost)
    }
}
