//
//  ViewController.swift
//  GG1l12Serialization
//
//  Created by Ivan Vasilevich on 6/2/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
  
  let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    writeToPlist(["keyInt" : 20])
    print(getDictFromPlist())
    JSONGrabber.init().sendRequest()
    nsKeyedArchiverUnurhiver()
    
    let loginButton = FBSDKLoginButton()
    // Optional: Разместите кнопку в центре представления.
    loginButton.center = view.center
    loginButton.delegate = self
    view.addSubview(loginButton)
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
  
  func nsKeyedArchiverUnurhiver() {
    // setting a value for a key
    let label = UILabel()
    label.text = "DVER MNE ZAPILI"
    let newPerson = Person(name: "Joe", age: 10, label: label)
    var people = [Person]()
    people.append(newPerson)
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: people)
    UserDefaults.standard.set(encodedData, forKey: "people")
    
    // retrieving a value for a key
    if let data = UserDefaults.standard.data(forKey: "people"),
      let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] {
      myPeopleList.forEach({print( $0.name, $0.age, $0.label.text)})  // Joe 10
    } else {
      print("There is an issue")
    }
  }
  
}

extension ViewController: FBSDKLoginButtonDelegate {
  public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
  }
  
  
  /**
   Sent to the delegate when the button was used to logout.
   - Parameter loginButton: The button that was clicked.
   */
  public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
  }
  
  
  /**
   Sent to the delegate when the button is about to login.
   - Parameter loginButton: the sender
   - Returns: YES if the login should be allowed to proceed, NO otherwise
   */
  public func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
    return true
  }
}

