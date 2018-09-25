//
//  ViewController.swift
//  xAFDebugger
//
//  Created by akinogunc on 09/25/2018.
//  Copyright (c) 2018 akinogunc. All rights reserved.
//

import UIKit
import Alamofire
import xAFDebugger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let debugger = xAFDebugger(self)
        
        Alamofire.request("https://jsonplaceholder.typicode.com/posts").responseJSON { response in
            
            debugger.debug(response: response)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

