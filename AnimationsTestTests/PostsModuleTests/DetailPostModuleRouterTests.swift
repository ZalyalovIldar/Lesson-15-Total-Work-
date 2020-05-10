//
//  DetailPostModuleRouterTests.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class DetailPostModuleRouterTests: XCTestCase {
    
    var router: DetailPostModuleRouter!
    var view: UIViewController!

    override func setUpWithError() throws {
        
        router = DetailPostModuleRouter()
        view = UIViewController()
        
        router.view = view
    }

    override func tearDownWithError() throws {
        
        view = nil
        router = nil
    }

    func testEndEditingWithoutChanges() throws {
        
        router.endEditing()
        
        XCTAssertTrue(view.presentedViewController?.presentedViewController != view)
    }
    
    func testEndEditingWithChanges() throws {
        
        let delegate = PostsModuleViewController()
        let presenter = PostsModulePresenterMock()
        delegate.presenter = presenter
        
        router.endEditingWithUpdate(delegate: delegate)
        
        XCTAssertTrue(view.presentedViewController?.presentedViewController != view)
    }
}
