//
//  ZOWebScreenZOWebScreenInitializer.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import UIKit

class WebScreenModuleInitializer: NSObject {
    
    convenience init(webscreenViewController: WebScreenViewController, parameters: [String] , loadCompletion: @escaping OpenCompletion, closeButtonCompletion: @escaping TouchedCloseCompletion) {
        self.init()
        let configurator = WebScreenModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: webscreenViewController, parameters: parameters, loadCompletion: loadCompletion, closeButtonCompletion: closeButtonCompletion)
    }
}
