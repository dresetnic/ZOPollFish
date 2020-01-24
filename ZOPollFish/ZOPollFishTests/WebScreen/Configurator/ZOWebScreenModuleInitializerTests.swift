//
//  WebScreenModuleInitializerTests.swift
//  ZOPollFishTests
//
//  Created by Dragos Resetnic on 23/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import XCTest
@testable import ZOPollFish

class ZOWebScreenModuleInitializerTests: XCTestCase {

    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWebscreenViewController() {
        
        //given
        let viewController = WebScreenViewControllerMock()

        let _ = WebScreenModuleInitializer(webscreenViewController: viewController, parameters: ["1", "2", "3", "4", "5"], loadCompletion: { (_) in print("open completion") }, closeButtonCompletion: {print("Touched close")})
        
        //then
        XCTAssertNotNil(viewController.output, "WebScreenViewController is nil after configuration")
        XCTAssertTrue(viewController.output is WebScreenPresenter, "output is not WebScreenPresenter")

        let presenter: WebScreenPresenter = viewController.output as! WebScreenPresenter
        XCTAssertNotNil(presenter.view, "view in WebScreenPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in WebScreenPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is WebScreenRouter, "router is not WebScreenRouter")

        let interactor: WebScreenInteractor = presenter.interactor as! WebScreenInteractor
        XCTAssertNotNil(interactor.output, "output in WebScreenInteractor is nil after configuration")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    class WebScreenViewControllerMock: WebScreenViewController {

           var setupInitialStateDidCall = false

           override func setupInitialState() {
               setupInitialStateDidCall = true
           }
       }

}
