//
//  RouterTests.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class RouterTests: XCTestCase {
    
    var presenter: PresenterMock!
    var router: MainRouter!
    var sampleView = UIViewController()

    override func setUpWithError() throws {
        
        presenter = PresenterMock()
        router = MainRouter()
        
        router.presenter = presenter
        router.view = sampleView
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldPresentRenamingAlert() throws {
        
        router.showRenamingAlert(initial: String(), indexPath: IndexPath(item: .zero, section: .zero))
        
        let exp = expectation(description: "shouldPresentRenamingAlert")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sampleView.presentedViewController is UIAlertController)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShouldPresentErrorAlert() throws {
        
        router.showErrorAlert(text: "ERR0R!1")
        
        let exp = expectation(description: "shouldPresentRenamingAlert")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sampleView.presentedViewController is UIAlertController)
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
