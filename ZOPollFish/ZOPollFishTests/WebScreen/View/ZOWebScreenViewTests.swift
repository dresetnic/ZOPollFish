//
//  ZOWebScreenZOWebScreenViewTests.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import XCTest
@testable import ZOPollFish

class WebScreenViewTests: XCTestCase {
    
    let view = WebScreenViewController()
    let presenter = MockPresenter()
    
    let mockParameters = Parameters(parameter1: "1", parameter2: "2", adIdentifier: "3")

    override func setUp() {
        super.setUp()
        
        view.output = presenter
        presenter.view = view
        presenter.methodWasCalled = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view.output = nil
        presenter.methodWasCalled = false
        super.tearDown()
    }
    
    func testSetupConstraints(){
        self.view.viewDidLoad()
        
    }
    
    func testViewDidLoad(){
        self.view.viewDidLoad()
        XCTAssertTrue(self.presenter.methodWasCalled, "viewDidLoad() shold called viewIsReady on presenter")
    }
    
    func testToucheCloseButton(){
        self.view.toucheCloseButton()
        XCTAssertTrue(self.presenter.methodWasCalled, "viewDidLoad() shold called touchedClose on presenter")
    }
    
    func testLoadParameters(){
        self.view.setupInitialState()
        self.view.load(parameters: mockParameters)
        XCTAssertTrue(view.adIdentifierLabel.text == mockParameters.adIdentifier, "Those should be equal")
    }
        
    func testViewIsReady(){
        view.output.viewIsReady()
        XCTAssertTrue(presenter.methodWasCalled, "Should call viewIsReady")
    }
    
    func testTouchedClose(){
        view.output.touchedClose()
        XCTAssertTrue(presenter.methodWasCalled, "Should call touchedClose")
    }
    
    func testLoadedUrl(){
        view.output.loadedUrl()
        XCTAssertTrue(presenter.methodWasCalled, "Should call loadedUrl")
    }
    
    func testFailedToLoadUrl(){
        view.output.failedToLoadUrl()
        XCTAssertTrue(presenter.methodWasCalled, "Should call loadedUrl")
    }
    
    class MockPresenter: WebScreenPresenter {
                
        var methodWasCalled = false
        
        override func viewIsReady() {
            methodWasCalled = true
        }
        
        override func touchedClose() {
            methodWasCalled = true
        }
        
        override func loadedUrl() {
            methodWasCalled = true
        }
        
        override func failedToLoadUrl() {
            methodWasCalled = true
        }
    }
}
