//
//  ViewTests.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class ViewTests: XCTestCase {
    
    var view: MainViewController!
    
    override func setUpWithError() throws {
        
        view = MainViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNormalizedCompletionPercentageIsCalculatedCorrectlyForTopPanAnimator() throws {
        
        let rawPercentage = 0.3
        
        view.updatePanAnimationPercentage(with: rawPercentage)
        
        XCTAssertEqual(view.panAnimator.fractionComplete, 0.4)
    }
    
    func testNormalizedCompletionPercentageIsCalculatedCorrectlyForBottomPanAnimator() throws {
        
        let rawPercentage = 0.6
        
        view.updatePanAnimationPercentage(with: rawPercentage)
        
        XCTAssertEqual(view.bottomPanAnimator.fractionComplete, 0.1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
