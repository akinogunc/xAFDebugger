# xAFDebugger

[![Version](https://img.shields.io/cocoapods/v/xAFDebugger.svg?style=flat)](https://cocoapods.org/pods/xAFDebugger)
[![License](https://img.shields.io/cocoapods/l/xAFDebugger.svg?style=flat)](https://cocoapods.org/pods/xAFDebugger)
[![Platform](https://img.shields.io/cocoapods/p/xAFDebugger.svg?style=flat)](https://cocoapods.org/pods/xAFDebugger)

<img align="center" src="https://github.com/akinogunc/xAFDebugger/blob/master/ss.png?raw=true" width="300">

## Example

First import the module

```swift
import xAFDebugger
```

Then create an instance of xAFDebugger

```swift
let debugger = xAFDebugger(self)
```

Catch the response in the Alomafire request block

```swift
Alamofire.request("https://jsonplaceholder.typicode.com/posts").responseJSON { response in
  debugger.debug(response: response)
}
```


## Requirements

- iOS 9.0+
- Xcode 9+
- Swift 4, 4.1 & 4.2
- Alomafire


## Installation

xAFDebugger is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'xAFDebugger'
```

## Author

akinogunc, akinogunc@gmail.com

## License

xAFDebugger is available under the MIT license. See the LICENSE file for more info.
