//
//  ZOPollFishTests.swift
//  ZOPollFishTests
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import XCTest
@testable import ZOPollFish

class ZOManagerTests: XCTestCase {
    
    var manager: ZOManager!
    var managerMock: ZOManagerMock!

    
    override func setUp() {
        
        manager = ZOManager()
        manager.setupWith(parameters: "1", "2", "3", "4", "5") { (param3, param4, param5) in  }
        
        managerMock = ZOManagerMock()
        managerMock.setupWith(parameters: "1", "2", "3", "4", "5") { (param3, param4, param5) in  }

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        manager = nil
        managerMock = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRotatedNoDevice(){
        
        var rotated = false
        
        manager.openCompletion = { (_) in
            rotated = true
        }
        
        manager.rotated()
        
        XCTAssertTrue(!rotated, "rotated method should not call openCompletion ")
    }
    
    func testSetupWithMethod(){
                
        XCTAssertNotNil(manager.closeCompletion)
        XCTAssertTrue(manager.parameters.count == 5)
    }
    
    func testShowScreenWithoutWindow(){
        self.manager.showScreenWith { (_) in }
                
        XCTAssertNil(manager.keyWindow)
        XCTAssertNotNil(manager.openCompletion)
        XCTAssertNotNil(manager.closeCompletion)
    }
    
    func testShowScreenWithWindow(){
                
        managerMock.showScreenWith { (_) in }
                
        XCTAssertNotNil(managerMock.viewController)
    }
    
    
    func testHideScreen(){
        
        let viewController = WebScreenViewControllerMock()
        self.managerMock.viewController = viewController
        
        self.managerMock.hideScreenWith {(_, _, _) in }
        
        XCTAssertNotNil(managerMock.viewController)
        XCTAssertNotNil(managerMock.closeCompletion)
    }
    
    func testSetOpenCloseAnimationTime(){
        self.manager.setOpenCloseAnimationTime(withDuration: 2)
        
        XCTAssertTrue(self.manager.animationDuration == 2, "Animatian duration changed from default 1 to 2")
    }
    
    func testSetupWithParameters(){
        manager.setupWith(parameters: "1", "2", "3", "4", "5") { (param3, param4, param5) in  }
        
        XCTAssertTrue(self.manager.parameters.count == manager.parametersNumber)
    }
    
    func testCleanView(){
        
        let viewController = WebScreenViewControllerMock()
        
        self.manager.viewController = viewController
        
        let window = UIWindow()
        window.addSubview(viewController.view)

        self.manager.cleanView()
        XCTAssertNil(self.manager.viewController)
    }

    class WebScreenViewControllerMock: WebScreenViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
        
        override func viewDidLoad() {
            
        }
    }
    
    class ZOManagerMock: ZOManager{
        
        override var keyWindow: UIWindow? {
            get{
                return UIWindow()
            }
        }
        
    }
}
