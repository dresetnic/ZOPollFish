# ZOPollFish

A library/framework that renders a webview overlay above any app.

## Using ZOPollFish in a iOS application ##

To add the ZOPollFish framework to your iOS application, either drag the ZOPollFish.xcodeproj project into your application's project or add it via File | Add Files To...

After that, go to your project's Build Phases and add ZOPollFish as a Target Dependency. Add it to the Link Binary With Libraries phase. Add a new Copy Files build phase, set its destination to Frameworks, and add ZOPollFish.framework. That last step will make sure the framework is deployed in your application bundle.

In any of your Swift files that reference ZOPollFish classes, simply add

```swift
import ZOPollFish
```

and you should be ready to go.

## Setup

Use the setup method before showing or hiding screens and pass five string parameters or more and a completion block. Close completion will pass back to the user: Param 3, Param 4, and Param 5.

```swift

ZOManager.shared.setupWith(parameters: "🧘‍♂️param1", "🪂param2", "🥋param3", "⛷param4", "🏍param5") { (param3, param4, param5) in
    //Close completion
    print(param3, param4, param5)
}

```

## Performing common tasks ##

Use showScreenWith method to show webview overlay.

```swift

ZOManager.shared.showScreenWith { (isSuccess) in
    print("All good")
}

```

Use hideScreenWith method to hide webview overlay. This method hides the current view (use it if you want to close view automatically using a timer or programmatically). Completion will be called when the  hide animation is finished.


```swift

ZOManager.shared.hideScreenWith() { (param3, param4, param5) in
    
}

```
