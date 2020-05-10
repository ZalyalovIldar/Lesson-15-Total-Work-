//
//  AnimationsTestUITests.swift
//  AnimationsTestUITests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest

class AnimationsTestUITests: XCTestCase {
    
    func testOpeningFullscreenDetailsView() throws {

        let app = XCUIApplication()
        app.launch()

        app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["dolorem eum magni eos aperiam quia"]/*[[".cells.staticTexts[\"dolorem eum magni eos aperiam quia\"]",".staticTexts[\"dolorem eum magni eos aperiam quia\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.scrollViews.otherElements.buttons["Close"].waitForExistence(timeout: 1.0))
    }
    
    func testFullscreenDetailsViewCloseWhileSwipingDown() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.staticTexts["dolorem eum magni eos aperiam quia"].tap()
        app.scrollViews.otherElements.containing(.button, identifier:"Close").element.swipeDown()
        
        XCTAssertTrue(!app.scrollViews.otherElements.containing(.button, identifier:"Close").element.waitForExistence(timeout: 1.0))
    }
    
    func testOpeningPreviewDetailsView() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.cells/*@START_MENU_TOKEN@*/.staticTexts["dolorem eum magni eos aperiam quia"].press(forDuration: 1.2);/*[[".cells.staticTexts[\"dolorem eum magni eos aperiam quia\"]",".tap()",".press(forDuration: 1.2);",".staticTexts[\"dolorem eum magni eos aperiam quia\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(app.scrollViews.images["DetailViewImage"].waitForExistence(timeout: 1.0))
    }
    
    func testOpeningPreviewDetailsViewToFullscreenWhileSwipingUp() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.cells.staticTexts["dolorem eum magni eos aperiam quia"].press(forDuration: 1.2);
        app.scrollViews.otherElements.containing(.image, identifier:"DetailViewImage").element.swipeUp()
        
        XCTAssertTrue(app.scrollViews.otherElements.containing(.button, identifier:"Close").element.waitForExistence(timeout: 1.0))
    }
    
    func testClosingPreviewDetailsViewWhileSwipingDown() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.cells.staticTexts["dolorem eum magni eos aperiam quia"].press(forDuration: 1.2);
        app.scrollViews.otherElements.containing(.image, identifier:"DetailViewImage").element.swipeDown()
        
        XCTAssertTrue(!app.scrollViews.otherElements.containing(.button, identifier:"Close").element.waitForExistence(timeout: 1.0))
    }
    
    func testOpeningPreviewDetailsViewToFullscreenWhileTappingOnIt() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.cells.staticTexts["dolorem eum magni eos aperiam quia"].press(forDuration: 1.2);
        app.scrollViews.otherElements.containing(.image, identifier:"DetailViewImage").element.tap()
        
        XCTAssertTrue(app.scrollViews.otherElements.containing(.button, identifier:"Close").element.waitForExistence(timeout: 1.0))
    }
}
