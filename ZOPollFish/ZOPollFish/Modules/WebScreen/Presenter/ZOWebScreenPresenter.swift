//
//  WebScreenZOWebScreenPresenter.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

class WebScreenPresenter: WebScreenModuleInput, WebScreenViewOutput, WebScreenInteractorOutput {

    weak var view: WebScreenViewInput!
    var interactor: WebScreenInteractorInput!
    var router: WebScreenRouterInput!

    var loadCompletion: OpenCompletion!
    var touchCloseCompletion: TouchedCloseCompletion!
    var parameters: [String]!
    var adIdentifier: String!
    
    var loadedPage = false
    var hasAdIdentifier = false
    let totalParallelEventsNumber = 2
    var parallelEventsCounter = 0 {
        didSet{
            checkState()
        }
    }
    
    func viewIsReady() {
        self.interactor.getAdIdentifier()
    }
    
    func touchedClose(){
        self.touchCloseCompletion()
    }
    
    func loadedUrl(){
        loadedPage = true
        parallelEventsCounter += 1
    }
    
    func failedToLoadUrl(){
        loadedPage = false
        parallelEventsCounter += 1
    }
    
    func adIdentifierLimited() {
        hasAdIdentifier = false
        parallelEventsCounter += 1
    }
    
    func loadedAdIdentifier(identifier: String) {
        adIdentifier = identifier
        hasAdIdentifier = true
        parallelEventsCounter += 1
    }
    
    func checkState(){
        if parallelEventsCounter == totalParallelEventsNumber {
            let isSuccess = hasAdIdentifier && loadedPage
            
            if isSuccess {
                let parameters = Parameters(parameter1: self.parameters.first!, parameter2: self.parameters[1], adIdentifier: self.adIdentifier)
                self.view.load(parameters: parameters)
            }
            
            self.loadCompletion(isSuccess)
        }
    }
}
