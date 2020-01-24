//
//  ZOWebScreenZOWebScreenInteractorTests.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import XCTest
@testable import ZOPollFish

class WebScreenInteractorTests: XCTestCase {

    let interactor = WebScreenInteractor()
    let presenter = MockPresenter()
    
    let mockId = "00000000-0000-0000-0000-000000000000"
    
    override func setUp() {
        super.setUp()
        
        interactor.output = presenter
        presenter.methodWasCalled = false
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        presenter.methodWasCalled = false
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testgetAdIdentifierSucces(){
        interactor.adIdentifierIsAvailable = true
        interactor.getAdIdentifier()
        XCTAssertTrue(presenter.methodWasCalled, "Should call one of presenter methods")
    }
    
    func testgetAdIdentifierFail(){
         interactor.adIdentifierIsAvailable = false
         interactor.getAdIdentifier()
         XCTAssertTrue(presenter.methodWasCalled, "Should call one of presenter methods")
     }
    
    
    func testAdIdentifierLimited(){
        interactor.output.adIdentifierLimited()
        XCTAssertTrue(presenter.methodWasCalled, "Should call adIdentifierLimited method")
    }
    
    func testLoadedAdIdentifier(){
        interactor.output.loadedAdIdentifier(identifier: mockId)
        XCTAssertTrue(presenter.methodWasCalled, "Should call loadedAdIdentifier method")
    }

    class MockPresenter: WebScreenInteractorOutput {
        
        var methodWasCalled = false
        
        func adIdentifierLimited() {
            methodWasCalled = true
        }
        
        func loadedAdIdentifier(identifier: String) {
            methodWasCalled = true
        }
    }
}
