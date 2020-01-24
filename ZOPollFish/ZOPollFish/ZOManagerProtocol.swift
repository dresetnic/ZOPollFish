//
//  ZOManagerProtocol.swift
//  ZOPollFish
//
//  Created by Dragos Resetnic on 23/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import Foundation

public typealias OpenCompletion = (Bool)->Void
public typealias CloseCompletion = (String, String, String)->Void
public typealias TouchedCloseCompletion = ()->Void

public protocol ZOManagerProtocol {
    
    /// Setup framework with 5 parametrs and a close completion block
    /// - Parameters:
    ///   - parameters:  5 string parameters
    ///   - closeCompletion: This completion will be called when the user clicks the close button.
     func setupWith(parameters: String..., closeCompletion: @escaping CloseCompletion)
    
    /// This method will show the screen when the web view is loaded, and the ad identifier is retrieved. If some of the two mentioned above fail to load, then it will call the completion block with a false parameter.
    /// - Parameter completion: Completion block that will be executed
     func showScreenWith(completion: @escaping OpenCompletion)
    
    /// This method hides the current view (use it if you want to close view automatically using a timer or programmatically).
    /// - Parameter completion: This completion will be called when the  hide animation is finished.
     func hideScreenWith(completion: @escaping CloseCompletion)
    
    
    /// Change hide and show default animation duration.
    /// - Parameter duration: TimeInterval default value is equal to 1.
     func setOpenCloseAnimationTime(withDuration duration: TimeInterval)
}
