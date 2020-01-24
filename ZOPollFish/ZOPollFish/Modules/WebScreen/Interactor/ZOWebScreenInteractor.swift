//
//  ZOWebScreenZOWebScreenInteractor.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import AdSupport

class WebScreenInteractor: WebScreenInteractorInput {
    
    weak var output: WebScreenInteractorOutput!
    
    var adIdentifierIsAvailable: Bool = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    
    func getAdIdentifier() {
        
        if adIdentifierIsAvailable {
            let identifier = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            self.output.loadedAdIdentifier(identifier: identifier)
        } else {
            self.output.adIdentifierLimited()
        }
    }
}
