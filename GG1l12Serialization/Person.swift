//
//  Person.swift
//  GG1l12Serialization
//
//  Created by Ivan Vasilevich on 6/2/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
  let name: String
  let age: Int
  let label: UILabel
  init(name: String, age: Int, label: UILabel) {
    self.name = name
    self.age = age
    self.label = label
  }
  required init(coder decoder: NSCoder) {
    self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
    self.age = decoder.decodeInteger(forKey: "age")
    self.label = decoder.decodeObject(forKey: "label") as? UILabel ?? UILabel()
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(name, forKey: "name")
    coder.encode(age, forKey: "age")
    coder.encode(label, forKey: "label")
  }
}
