//
//  WebScreenZOWebScreenViewInput.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

protocol WebScreenViewInput: class {

    /**
        @author Dragos Resetnic
        Setup initial state of the view
    */

    func setupInitialState()
    func load(parameters: Parameters)
    
}
