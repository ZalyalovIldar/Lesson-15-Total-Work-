//
//  DataSourceTest.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class DataSourceTest: XCTestCase {
    
    var dataSource: MainDataSource!
    var presenter: PresenterMock!

    override func setUpWithError() throws {
        
        dataSource = MainDataSource()
        presenter = PresenterMock()
        
        dataSource.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresenterShouldCallDidLoadImage() throws {
        
        dataSource.didLoadImage(data: Data(), id: .zero)
        
        XCTAssertTrue(presenter.shouldCallDidLoadImage)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
