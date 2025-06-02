//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Felipe Martins on 29/05/25.
//

import XCTest

final class PokedexUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigatesToPokemonDetailAndChecksLabels(){
        
        let app = XCUIApplication()
        app.launchArguments = ["-UITestMode"]
        app.launch()
        
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
        
        let nameLabel = app.staticTexts["name-label"]
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(nameLabel.label, "Bulbasaur")
        
        let firstTypeLabel = app.staticTexts["type-label-1"]
        XCTAssertTrue(firstTypeLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(firstTypeLabel.label, "Grass")
        
        let secondTypeLabel = app.staticTexts["type-label-2"]
        XCTAssertTrue(secondTypeLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(secondTypeLabel.label, "Poison")
        
        let statHpLabel = app.staticTexts["stat-label-Hp"]
        XCTAssertTrue(statHpLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(statHpLabel.label, "45")
        
        let statAttackLabel = app.staticTexts["stat-label-Attack"]
        XCTAssertTrue(statAttackLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(statAttackLabel.label, "49")
        
        let statDefenseLabel = app.staticTexts["stat-label-Defense"]
        XCTAssertTrue(statDefenseLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(statDefenseLabel.label, "49")
        
        let statSpeedLabel = app.staticTexts["stat-label-Speed"]
        XCTAssertTrue(statSpeedLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(statSpeedLabel.label, "45")
        
        
    }
}
