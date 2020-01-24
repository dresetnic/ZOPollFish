//
//  WebScreenZOWebScreenViewOutput.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

protocol WebScreenViewOutput {

    /**
        @author Dragos Resetnic
        Notify presenter that view is ready
    */

    func viewIsReady()
    func touchedClose()

    func loadedUrl()
    func failedToLoadUrl()
}
