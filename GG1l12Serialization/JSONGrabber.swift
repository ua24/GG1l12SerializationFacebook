//
//  JSONGrabber.swift
//  GG1l12Serialization
//
//  Created by Ivan Vasilevich on 6/2/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit

class JSONGrabber {
  func sendRequest() {
    /* Configure session, choose between:
     * defaultSessionConfiguration
     * ephemeralSessionConfiguration
     * backgroundSessionConfigurationWithIdentifier:
     And set session-wide properties, such as: HTTPAdditionalHeaders,
     HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
     */
    let sessionConfig = URLSessionConfiguration.default
    
    /* Create session, and optionally set a URLSessionDelegate. */
    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    
    /* Create the Request:
     My API (GET https://newsapi.org/v1/articles)
     */
    
    guard var URL = URL(string: "https://newsapi.org/v1/articles") else {return}
    let URLParams = [
      "source": "bbc-sport",
      "sortBy": "top",
      "apiKey": "243d159529bb40e3bdc0988d0cb866cd",
      ]
    URL = URL.appendingQueryParameters(URLParams)
    var request = URLRequest(url: URL)
    request.httpMethod = "GET"
    
    /* Start a new Task */
    let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
      if (error == nil) {
        // Success
        let statusCode = (response as! HTTPURLResponse).statusCode
        let parsedData = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
        print(try! JSONSerialization.data(withJSONObject: parsedData, options: .prettyPrinted))
        print("URL Session Task Succeeded: HTTP \(statusCode)")
        
      }
      else {
        // Failure
        print("URL Session Task Failed: %@", error!.localizedDescription);
      }
    })
    task.resume()
    session.finishTasksAndInvalidate()
  }
}


protocol URLQueryParameterStringConvertible {
  var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
  /**
   This computed property returns a query parameters string from the given NSDictionary. For
   example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
   string will be @"day=Tuesday&month=January".
   @return The computed parameters string.
   */
  var queryParameters: String {
    var parts: [String] = []
    for (key, value) in self {
      let part = String(format: "%@=%@",
                        String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                        String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      parts.append(part as String)
    }
    return parts.joined(separator: "&")
  }
  
}

extension URL {
  /**
   Creates a new URL by adding the given query parameters.
   @param parametersDictionary The query parameter dictionary to add.
   @return A new URL.
   */
  func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
    let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
    return URL(string: URLString)!
  }
}
