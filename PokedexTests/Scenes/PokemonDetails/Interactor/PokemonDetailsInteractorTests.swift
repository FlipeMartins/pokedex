//
//  PokemonDetailsInteractorTests.swift
//  PokedexTests
//
//  Created by Felipe Martins on 01/06/25.
//

import XCTest
@testable import Pokedex

final class PokemonDetailsInteractorTests: XCTestCase {
    
    var sut: PokemonDetailsInteractor?
    var serviceMock: PokemonDetailsTestServiceMock?
    var presenterMock: PokemonDetailsTestPresenterMock?
    var analytcsManagerMock: AnalyticsManagerMock?
    
    override func setUp() {
        serviceMock = PokemonDetailsTestServiceMock()
        presenterMock = PokemonDetailsTestPresenterMock()
        analytcsManagerMock = AnalyticsManagerMock()
        
        guard presenterMock != nil, serviceMock != nil, analytcsManagerMock != nil else {
            XCTFail()
            return
        }
        
        sut = PokemonDetailsInteractor(inputData: .init(itemId: 1), presenter: presenterMock!, service: serviceMock!, analyticsManager: analytcsManagerMock!)
    }
    
    override func tearDown() {
        sut = nil
        serviceMock = nil
        presenterMock = nil
    }
    
    func testInteractor_WhenStartFlowCalled_ShouldCallStartLoadOnPresent() {
        
        // Arrange
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
        let result = presenterMock?.presentStartLoadingCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    func testInteractor_WhenStartFlowCalled_ShouldCallGetPokemonDetailsOnPresent() {
        
        // Arrange
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
        let result = serviceMock?.getPokemonDetailsCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    func testInteractor_WhenStartFlowCalledAndServiceReturns_ShouldCallStopLoadOnPresent() {
        
        // Arrange
        serviceMock?.configuration = .sucess
        let serviceExpectation = expectation(description: "Service Expectation")
        serviceMock?.getPokemonDetailsExpectation = serviceExpectation
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
        wait(for: [serviceExpectation], timeout: 1.0)
        
        let result = presenterMock?.presentStopLoadingCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    func testInteractor_WhenStartFlowCalledAndServiceReturnsSuccess_ShouldCallPresentPokemonDetailsOnPresent() {
        
        // Arrange
        serviceMock?.configuration = .sucess
        let serviceExpectation = expectation(description: "Service Expectation")
        serviceMock?.getPokemonDetailsExpectation = serviceExpectation
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
        wait(for: [serviceExpectation], timeout: 1.0)
        
        let result = presenterMock?.presentPokemonDetailsCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    func testInteractor_WhenStartFlowCalledAndServiceReturnsFailure_ShouldCallPresentEmptyStateOnPresent() {
        
        // Arrange
        serviceMock?.configuration = .failure
        let serviceExpectation = expectation(description: "Service Expectation")
        serviceMock?.getPokemonDetailsExpectation = serviceExpectation
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
        wait(for: [serviceExpectation], timeout: 1.0)
        
        let result = presenterMock?.presentEmptyStateCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    
    func testInteractor_WhenStartFlowCalled_ShouldCallAnalytcsManager() {
        
        // Arrange
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
      
        let result = analytcsManagerMock?.trackCalled ?? false
        XCTAssertTrue(result)
        
    }
    
    func testInteractor_WhenStartFlowCalledWithRetry_ShouldCallAnalytcsManagerWithCorrectConfiguration() {
        
        // Arrange
        
        // Act
        sut?.startFlow(request: .init(isRetry: true))
        
        // Assert
      
        let eventType = analytcsManagerMock?.event?.type ?? ""
        
        XCTAssertEqual(eventType, "user-interaction")
        
    }
    
    func testInteractor_WhenStartFlowCalledWithoutRetry_ShouldCallAnalytcsManagerWithCorrectConfiguration() {
        
        // Arrange
        
        // Act
        sut?.startFlow(request: .init())
        
        // Assert
      
        let eventType = analytcsManagerMock?.event?.type ?? ""
        
        XCTAssertEqual(eventType, "screen-view")
        
    }
    
}
