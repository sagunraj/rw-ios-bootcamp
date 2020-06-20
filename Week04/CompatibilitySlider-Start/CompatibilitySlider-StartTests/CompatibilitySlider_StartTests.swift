//
//  CompatibilitySlider_StartTests.swift
//  CompatibilitySlider-StartTests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest
@testable import CompatibilitySlider_Start

class CompatibilitySlider_StartTests: XCTestCase {
    
    var sut: ViewController!

    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCalculateCompatibility() {
        let person1 = Person(id: 1, items: ["Cats": 1.0, "Dogs": 2.0, "Rabbits": 3.0, "Fishes": 4.0, "Ducks": 5.0, "Chickens": 5.0])
        let person2 = Person(id: 2, items: ["Cats": 1.0, "Dogs": 2.0, "Rabbits": 3.0, "Fishes": 4.0, "Ducks": 5.0, "Chickens": 5.0])
        let sutResult = sut.calculateCompatibility(with: person1, and: person2)
        XCTAssertEqual(sutResult, 100.0)
    }

}
