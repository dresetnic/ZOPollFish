//
//  ZOWebScreenZOWebScreenConfigurator.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import UIKit

class WebScreenModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, parameters: [String] , loadCompletion: @escaping OpenCompletion, closeButtonCompletion: @escaping TouchedCloseCompletion) {

        if let viewController = viewInput as? WebScreenViewController {
            configure(viewController: viewController,parameters: parameters, loadCompletion: loadCompletion, closeButton: closeButtonCompletion)
        }
    }
    
    
    private func configure(viewController: WebScreenViewController, parameters: [String] , loadCompletion: @escaping OpenCompletion, closeButton: @escaping TouchedCloseCompletion) {

    let router = WebScreenRouter()

    let presenter = WebScreenPresenter()
    presenter.view = viewController
    presenter.router = router
    presenter.parameters = parameters
    presenter.loadCompletion = loadCompletion
    presenter.touchCloseCompletion = closeButton

    let interactor = WebScreenInteractor()
    interactor.output = presenter

    presenter.interactor = interactor
    viewController.output = presenter
    }

}
