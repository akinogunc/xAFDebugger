//
//  xAFDebugger.swift
//  xAFNetworkDebugger
//
//  Created by Maruf Nebil Ogunc on 15.09.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit
import Alamofire

public class xAFDebugger: UIViewController {
    
    var responseData:DataResponse<Any>!
    var parentVC:UIViewController!
    var debugButton:UIButton!
    let screenRect = UIScreen.main.bounds
    var responseReceived = false
    
    public init(_ parentViewController:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        parentVC = parentViewController
        
        debugButton = UIButton(type: UIButtonType.custom)
        debugButton.setTitle("Show Debugger", for: UIControlState.normal)
        debugButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        debugButton.titleLabel?.textAlignment = NSTextAlignment.center
        debugButton.backgroundColor = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
        debugButton.frame = CGRect(x: 0, y: screenRect.size.height*0.9, width: screenRect.size.width, height: screenRect.size.height*0.1)
        debugButton.addTarget(self, action: #selector(self.showDebugger), for: UIControlEvents.touchUpInside)
        parentVC.view.addSubview(debugButton)
        
        
        parentVC.addChildViewController(self)
        self.view.frame = CGRect(x: 0, y: screenRect.height, width: screenRect.width, height: screenRect.height)
        parentVC.view.addSubview(self.view)
    }
    
    public func debug(response: DataResponse<Any>) -> Void {
        responseData = response
        responseReceived = true
        debugButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        prepareUI()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func closeDebugger() -> () {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.view.frame = CGRect(x: 0, y: self.screenRect.height, width: self.screenRect.width, height: self.screenRect.height)
        }, completion: { finished in
            
        })
        
    }
    
    @objc func showDebugger() -> Void {
        
        if responseReceived {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.view.frame = CGRect(x: 0, y: 0, width: self.screenRect.width, height: self.screenRect.height)
            }, completion: { finished in
                
            })
            
        }else{
            
            let alertController = UIAlertController(title: "Response not received", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    func prepareUI() -> () {
        
        let allStrings = NSMutableAttributedString()
        
        var boldText  = "URL: "
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        var attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        var normalText = (responseData.request?.url?.absoluteString)! + "\n"
        let attrs2 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        var normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        
        allStrings.append(attributedString)
        allStrings.append(normalString)
        
        
        //METHOD
        boldText  = "Response Code: "
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = String(responseData.response!.statusCode) + "\n"
        normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        
        allStrings.append(attributedString)
        allStrings.append(normalString)
        
        
        //CODE
        boldText  = "Method: "
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = (responseData.request?.httpMethod)! + "\n"
        normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        
        allStrings.append(attributedString)
        allStrings.append(normalString)
        
        
        //Duration
        boldText  = "Duration: "
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = responseData.timeline.totalDuration.formattedMilliseconds() + "\n\n"
        normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        
        allStrings.append(attributedString)
        allStrings.append(normalString)
        
        //Body
        
        if let json = responseData.result.value {
            let jsonData = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            boldText  = "Response:\n"
            attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            
            normalText = String(data: jsonData, encoding: .utf8)!
            normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
            
            allStrings.append(attributedString)
            allStrings.append(normalString)
        }
        
        
        let topInset:CGFloat = 50.0
        let closeButtonHeight = screenRect.size.height*0.1
        
        let responseTextView = UITextView(frame: CGRect(x:10, y:topInset, width:screenRect.size.width-20, height:screenRect.size.height - topInset - closeButtonHeight))
        responseTextView.textColor = UIColor.black
        responseTextView.backgroundColor = UIColor.white
        responseTextView.attributedText = allStrings
        responseTextView.textAlignment = NSTextAlignment.left
        responseTextView.isEditable = false
        self.view.addSubview(responseTextView)
        
        let closeButton = UIButton(type: UIButtonType.custom)
        closeButton.setTitle("Close Debugger", for: UIControlState.normal)
        closeButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        closeButton.titleLabel?.textAlignment = NSTextAlignment.center
        closeButton.backgroundColor = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
        closeButton.frame = CGRect(x: 0, y: screenRect.size.height*0.9, width: screenRect.size.width, height: closeButtonHeight)
        closeButton.addTarget(self, action: #selector(self.closeDebugger), for: UIControlEvents.touchUpInside)
        self.view.addSubview(closeButton)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension Double {
    func formattedMilliseconds() -> String{
        
        let rounded = self
        if rounded < 1000 {
            return String(format: "%.3f ms", rounded)
        } else if rounded < 1000 * 60 {
            let seconds = rounded / 1000
            return "\(Int(seconds))s"
        } else if rounded < 1000 * 60 * 60 {
            let secondsTemp = rounded / 1000
            let minutes = secondsTemp / 60
            let seconds = (rounded - minutes * 60 * 1000) / 1000
            return "\(Int(minutes))m \(Int(seconds))s"
        } else if self < 1000 * 60 * 60 * 24 {
            let minutesTemp = rounded / 1000 / 60
            let hours = minutesTemp / 60
            let minutes = (rounded - hours * 60 * 60 * 1000) / 1000 / 60
            let seconds = (rounded - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return "\(Int(hours))h \(Int(minutes))m \(Int(seconds))s"
        } else {
            let hoursTemp = rounded / 1000 / 60 / 60
            let days = hoursTemp / 24
            let hours = (rounded - days * 24 * 60 * 60 * 1000) / 1000 / 60 / 60
            let minutes = (rounded - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000) / 1000 / 60
            let seconds = (rounded - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return "\(Int(days))d \(Int(hours))h \(Int(minutes))m \(Int(seconds))s"
        }
    }
}
