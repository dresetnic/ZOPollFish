//
//  ZOManager.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 23/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import UIKit

public class ZOManager: ZOManagerProtocol {
    
    public static let shared: ZOManagerProtocol = ZOManager()
    
    let parametersNumber = 5
    var animationDuration: TimeInterval = 1
    
    var openCompletion:OpenCompletion?
    var closeCompletion:CloseCompletion?
    var parameters:[String] = []
    
    var viewController: WebScreenViewController?
    
    init(){
        self.addObservers()
    }
    
    deinit {
        self.removeObservers()
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated(){
        let orientation = UIDevice.current.orientation
        handle(orientation: orientation)
    }
    
    func handle(orientation: UIDeviceOrientation){
        
        guard let completion = openCompletion else {
            return
        }
        
        switch orientation {
        case .landscapeRight, .landscapeLeft, .portrait, .portraitUpsideDown:
            
            showScreenWith(completion: completion)
            
        default:
            break
        }
    }
    
    var keyWindow: UIWindow? {
        get {
            if #available(iOS 13, *) {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                return keyWindow
            } else {
                let keyWindow = UIApplication.shared.keyWindow
                return keyWindow
            }
        }
    }
    
    public func setupWith(parameters: String..., closeCompletion: @escaping CloseCompletion) {
        
        if parameters.count < parametersNumber {
            assertionFailure("You should pass at least \(parametersNumber) or more parameters: parameter1, parameter2, parameter3, parameter4, parameter5 ...")
        }
        
        self.parameters = parameters
        self.closeCompletion = closeCompletion
    }
    
    public func hideScreenWith(completion: @escaping CloseCompletion) {
        if parameters.count < parametersNumber {
            assertionFailure("Use setupWith: function before calling showScreen")
        }
        
        closeCompletion = completion
        
        if viewController != nil {
            self.animateHide()
        }
    }
    
    public func showScreenWith(completion: @escaping OpenCompletion) {
        if parameters.count < parametersNumber {
            assertionFailure("Use setupWith: function before calling showScreen")
        }
        openCompletion = completion
        
        cleanView()
        
        guard let window = keyWindow else {
            return
        }
        
        window.makeKeyAndVisible()
        
        viewController = WebScreenViewController()
        let _ = WebScreenModuleInitializer(webscreenViewController: viewController!, parameters: parameters, loadCompletion: { [weak self] (isSuccess) in
            
            if isSuccess {
                self?.animateShow()
            } else {
                self?.cleanView()
                self?.openCompletion?(false)
            }
        }) { [weak self] in
            self?.animateHide()
        }
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        window.addSubview(self.viewController!.view)
        
        viewController?.view.frame = CGRect(x: width, y: 0, width: width, height: height)
    }
    
    func cleanView(){
        if viewController?.view.superview != nil {
            viewController?.view.removeFromSuperview()
            viewController = nil
        }
    }
    
    func animateShow(){
        UIView.animate(withDuration: animationDuration, animations: {[weak self] in
            self?.viewController!.view.frame = CGRect(x: 0, y: self!.viewController!.view.frame.origin.y, width: self!.viewController!.view.frame.width , height: self!.viewController!.view.frame.height)
        }) { [weak self] (_) in
            self?.openCompletion!(true)
        }
    }
    
    func animateHide(){
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.viewController!.view.frame = CGRect(x: self!.viewController!.view.frame.width, y: self!.viewController!.view.frame.origin.y, width: self!.viewController!.view.frame.width , height: self!.viewController!.view.frame.height)
        }) { (_) in
            if self.viewController!.view.superview != nil {
                self.viewController!.view.removeFromSuperview()
                
            }
            if let completion = self.closeCompletion {
                completion(self.parameters[2], self.parameters[3], self.parameters[4])
            }
        }
    }
    
    public func setOpenCloseAnimationTime(withDuration duration: TimeInterval){
        self.animationDuration = duration
    }
}

