//
//  ViewController.swift
//  GG1l12Serialization
//
//  Created by Ivan Vasilevich on 6/2/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    writeToPlist(["keyInt" : 20])
  }
  
  func writeToPlist(_ dict: [String : Any]) {
    // path to documents directory
    let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    if let documentDirectoryPath = documentDirectoryPath as? NSString, let dictionary = dict as? NSDictionary {
      dictionary.write(toFile: documentDirectoryPath.appendingPathComponent("dict.plist"), atomically: true)
      print(documentDirectoryPath)
    }
  }
  
  
  
}

