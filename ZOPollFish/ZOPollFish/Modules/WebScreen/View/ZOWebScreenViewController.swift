//
//  WebScreenZOWebScreenViewController.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 22/01/2020.
//  Copyright © 2020 PollFish. All rights reserved.
//

import UIKit
import WebKit

class WebScreenViewController: UIViewController, WebScreenViewInput, WKNavigationDelegate {

    var output: WebScreenViewOutput!

    var webWiew = WKWebView()
    var closeButton = UIButton()
    
    var adIdentifierLabel = UILabel()
    
    var parameter1Label = UILabel()
    var parameter2Label = UILabel()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialState()
        output.viewIsReady()
    }

    // MARK: WebViewViewInput
    func setupInitialState() {
        addSubviews()
        setupContraints()
        setupViews()
    }
    
    func addSubviews(){
        
        let childSubviews:[UIView] = [webWiew ,parameter1Label, parameter2Label, adIdentifierLabel, closeButton]
        
        for child in childSubviews{
            child.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(child)
        }
    }
    
    func setupContraints(){

        var keyWindow: UIWindow?
        
        if #available(iOS 13, *) {
            keyWindow = (UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first)
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        
        guard let window = keyWindow else {
            return
        }
        
        let topInset = window.safeAreaInsets.top
        let bottomInset = window.safeAreaInsets.bottom

        //WebView
        webWiew.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webWiew.topAnchor.constraint(equalTo: self.view.topAnchor, constant: +topInset),
            webWiew.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomInset),
            webWiew.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webWiew.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Close button
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 45),
            closeButton.widthAnchor.constraint(equalToConstant: 45),
            closeButton.topAnchor.constraint(equalTo: self.webWiew.topAnchor, constant: +20),
            closeButton.leadingAnchor.constraint(equalTo: self.webWiew.leadingAnchor, constant: +20)
        ])
        
        //Parameter 1 Label
        
        NSLayoutConstraint.activate([
            parameter1Label.heightAnchor.constraint(equalToConstant: 45),
            parameter1Label.centerXAnchor.constraint(equalTo: self.webWiew.centerXAnchor),
            parameter1Label.topAnchor.constraint(equalTo: self.webWiew.topAnchor, constant: +20),
        ])
        
        //Parameter 2 Label
        
        NSLayoutConstraint.activate([
            parameter2Label.heightAnchor.constraint(equalToConstant: 45),
            parameter2Label.centerXAnchor.constraint(equalTo: self.parameter1Label.centerXAnchor),
            parameter2Label.bottomAnchor.constraint(equalTo: self.webWiew.bottomAnchor, constant: -20),
        ])
        
        //Ad Identifier Label
        
        NSLayoutConstraint.activate([
            adIdentifierLabel.centerXAnchor.constraint(equalTo: self.webWiew.centerXAnchor),
            adIdentifierLabel.centerYAnchor.constraint(equalTo: self.webWiew.centerYAnchor),
            adIdentifierLabel.heightAnchor.constraint(equalToConstant: 45),
            adIdentifierLabel.widthAnchor.constraint(equalTo: self.webWiew.widthAnchor)
        ])
    }
    
    func configureWebView(){
        webWiew.navigationDelegate = self
           let link = URL(string:"https://www.pollfish.com")!

           let request = URLRequest(url: link)
           webWiew.load(request)
    }
    
    func setupViews(){
        configureWebView()
        
        let image = UIImage(named: "close", in: Bundle(for: WebScreenViewController.self), compatibleWith: nil)
        closeButton.setImage( image, for: .normal)
        closeButton.addTarget(self, action: #selector(toucheCloseButton), for: .touchUpInside)
        
        for label in [parameter1Label, parameter2Label, adIdentifierLabel]{
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }
    }
    
    func load(parameters: Parameters){
        self.parameter1Label.text = parameters.parameter1
        self.parameter2Label.text = parameters.parameter2
        self.adIdentifierLabel.text = parameters.adIdentifier
    }

    @objc func toucheCloseButton(){
        self.output.touchedClose()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.output.loadedUrl()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.output.failedToLoadUrl()
    }
}
