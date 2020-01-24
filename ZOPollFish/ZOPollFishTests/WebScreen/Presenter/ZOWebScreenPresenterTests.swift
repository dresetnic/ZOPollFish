//
//  ZOWebScreenZOWebScreenPresenterTests.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import XCTest
@testable import ZOPollFish

class WebScreenPresenterTest: XCTestCase {

    let presenter = WebScreenPresenter()
    let router = MockRouter()
    let interactor = MockInteractor()
    let view = MockViewController()
    
    let mockParameters = Parameters(parameter1: "1", parameter2: "2", adIdentifier: "3")
    
    override func setUp() {
        super.setUp()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.loadCompletion = { (_) in  }
        presenter.touchCloseCompletion = { }
        presenter.parallelEventsCounter = 0
        presenter.parameters = ["1", "2", "3", "4", "5"]
        
        interactor.methodWasCalled = false
        view.methodWasCalled = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        interactor.methodWasCalled = false
        view.methodWasCalled = false
        self.presenter.parallelEventsCounter = 0

        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWebViewLoad(){
        self.presenter.loadedUrl()
        
        XCTAssertTrue(self.presenter.parallelEventsCounter == 1, "Should increase parallelEventsCounter by 1 from 0")

        self.presenter.failedToLoadUrl()
        
        XCTAssertTrue(self.presenter.parallelEventsCounter == 2, "Should increase parallelEventsCounter by 1 from 1")
    }
    
    func testTouchedClose(){
        
        var value = false
        
        self.presenter.touchCloseCompletion = { value = true }
        
        self.presenter.touchedClose()
        
        XCTAssertTrue(value, "touchCloseCompletion should be called inside touchedClose method")
    }
    
    func testCheckState(){
        self.presenter.loadedUrl()
        self.presenter.loadedAdIdentifier(identifier: "")
        
        self.presenter.checkState()
        
        XCTAssertTrue(self.view.methodWasCalled, "CheckState should load(parameters) method")
    }
    
    func testAdIdentifierMethods(){
        self.presenter.adIdentifierLimited()
        
        XCTAssertTrue(self.presenter.parallelEventsCounter == 1, "Should increase parallelEventsCounter by 1 from 0")

        self.presenter.loadedAdIdentifier(identifier: "")
        
        XCTAssertTrue(self.presenter.parallelEventsCounter == 2, "Should increase parallelEventsCounter by 1 from 1")
    }
    
    
    func testViewIsReady(){
        self.presenter.viewIsReady()
        XCTAssertTrue(self.interactor.methodWasCalled, "Should call getAdIdentifier method")
    }
    
    func testGetAdIdentifier(){
        self.presenter.interactor.getAdIdentifier()
        XCTAssertTrue(self.interactor.methodWasCalled, "Should call getAdIdentifier method")
    }
    
    func testSetupInitialState(){
        self.presenter.view.setupInitialState()
        XCTAssertTrue(self.view.methodWasCalled, "Should call setupInitialState method")
    }
    
    func testLoadParameters(){
        self.presenter.view.load(parameters: mockParameters)
        XCTAssertTrue(self.view.methodWasCalled, "Should call load(parameters method")
    }
    
    class MockInteractor: WebScreenInteractorInput {
        
        var methodWasCalled = false
        
        func getAdIdentifier() {
            methodWasCalled = true
        }
    }

    class MockRouter: WebScreenRouterInput {

    }

    class MockViewController: WebScreenViewInput {
        
        var methodWasCalled = false
        
        func setupInitialState() {
            methodWasCalled = true
        }
        
        func load(parameters: Parameters) {
            methodWasCalled = true
        }
    }
}
