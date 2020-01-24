//
//  ViewController.swift
//  ZOPollfishSDKSample
//
//  Created by Dragos Resetnic on 23/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import UIKit
import ZOPollFish

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ZOManager.shared.setupWith(parameters: "🧘‍♂️param1", "🪂param2", "🥋param3", "⛷param4", "🏍param5") { (param3, param4, param5) in
            //Close completion
            print(param3, param4, param5)
        }
        
        self.addObservers()
    }
    
    deinit {
        self.removeObservers()
    }
    
    func addObservers(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func appMovedToForeground(){
        ZOManager.shared.showScreenWith { (isSuccess) in
            print("All good")
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
}

