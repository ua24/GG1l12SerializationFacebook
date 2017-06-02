//
//  ViewController.swift
//  GG1l12Serialization
//
//  Created by Ivan Vasilevich on 6/2/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    writeToPlist(["keyInt" : 20])
    print(getDictFromPlist())
    JSONGrabber.init().sendRequest()
  }
  
  func writeToPlist(_ dict: [String : Any]) {
    // path to documents directory
    
    let dictionary = dict as NSDictionary
      dictionary.write(toFile: documentDirectoryPath.appendingPathComponent("dict.plist"), atomically: true)
      print(documentDirectoryPath)
  }
  
  func getDictFromPlist() -> [String : Any] {
    let dict = NSDictionary.init(contentsOfFile: documentDirectoryPath.appendingPathComponent("dict.plist"))
    return dict as! [String : Any]
  }
  
  
}

