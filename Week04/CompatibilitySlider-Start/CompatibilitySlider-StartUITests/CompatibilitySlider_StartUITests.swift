//
//  CompatibilitySlider_StartUITests.swift
//  CompatibilitySlider-StartUITests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest

class CompatibilitySlider_StartUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testCompatibilitySlider() {
        app = XCUIApplication()
        let items = ["Cats", "Dogs", "Rabbits", "Fishes", "Ducks", "Chickens"]
        
        let compatibilityItems = items.map { (item) -> XCUIElement in
            app.staticTexts[item]
        }
        
        let slider = app.sliders["50%"]
        let nextItemStaticText = app.staticTexts["Next Item"]
        
        func performSliderOperation(with item: XCUIElement,
                                    and sliderPosition: CGFloat) {
            XCTAssertTrue(item.exists)
            slider.adjust(toNormalizedSliderPosition: sliderPosition)
            nextItemStaticText.tap()
        }
        
        compatibilityItems.enumerated().forEach { (index, element) in
            performSliderOperation(with: element, and: CGFloat(index / 5))
        }
        
        app.alerts["Compatibility Slider"].scrollViews.otherElements.buttons["OK"].tap()
        
        compatibilityItems.enumerated().forEach { (index, element) in
            performSliderOperation(with: element, and: CGFloat(index / 5))
        }
        
        XCTAssert(app.alerts.element.staticTexts["You two are 100.0% compatible."].exists)
        
        app.alerts["Results"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
