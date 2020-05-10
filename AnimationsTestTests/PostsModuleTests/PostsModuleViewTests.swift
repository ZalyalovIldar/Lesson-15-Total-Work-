//
//  PostsModuleViewTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class PostsModuleViewTests: XCTestCase {
    
    var view: PostsModuleViewController!
    var postsTableView: UITableView!
    var presenter: PostsModulePresenterMock!
    var visualEffectView: UIVisualEffectView!

    override func setUpWithError() throws {
        
        view = PostsModuleViewController()
        postsTableView = UITableView()
        presenter = PostsModulePresenterMock()
        visualEffectView = UIVisualEffectView()
        
        view.postsTableView = postsTableView
        view.presenter = presenter
        view.visualEffectView = visualEffectView
        view.postsTableView.superview?.addSubview(visualEffectView)
    }

    override func tearDownWithError() throws {
        
        view = nil
        postsTableView = nil
        presenter = nil
    }

    func testUpdatingPostsArrayAfterLoadingPosts() throws {
        
        let counterOfRowsInTableBeforeTest = view.posts.count
        var counterOfRowsInTableAfterTest: Int!
        
        view.didFinishLoadingPosts(posts: [PostDto(userId: 0, id: 0, title: "Test", body: "test", imageUrl: "Test")])
        counterOfRowsInTableAfterTest = view.posts.count
        
        XCTAssertNotEqual(counterOfRowsInTableBeforeTest, counterOfRowsInTableAfterTest)
    }
    
    func testUpdatingPostsAfterEditingPost() throws {
        
        view.didFinishEditing()
        
        XCTAssertTrue(presenter.idLoadingPosts)
    }
    
    func testUpdatingPostsAfterDeletingPost()  throws {
        
        view.didFinishDeletingPost()
        
        XCTAssertTrue(presenter.idLoadingPosts)
    }
}
