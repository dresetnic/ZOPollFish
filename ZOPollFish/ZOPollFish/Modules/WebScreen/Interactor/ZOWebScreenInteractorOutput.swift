//
//  ZOWebScreenZOWebScreenInteractorOutput.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import Foundation

protocol WebScreenInteractorOutput: class {
    func adIdentifierLimited()
    func loadedAdIdentifier(identifier: String)
}
