//
//  ZOWebScreenZOWebScreenConfiguratorTests.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import XCTest
@testable import ZOPollFish


class WebScreenModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = WebScreenViewControllerMock()
        let configurator = WebScreenModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController, parameters: ["1", "2", "3", "4", "5"] , loadCompletion: { (_) in print("open completion") }, closeButtonCompletion: {print("Touched close")})

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

    class WebScreenViewControllerMock: WebScreenViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
