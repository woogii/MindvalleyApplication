//
//  MindvalleyImage.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - MindvalleyImage

open class MindvalleyImage {
  
  // MARK : - Properties
  
  open static let sharedInstance = MindvalleyImage()
  open static let dataCache = NSCache<NSString,DiscardableImageContent>()
  
  
  // MARK: - All purpose method for requesting data
  
  func requestImageWith(urlString: String, size:Int?=nil, completionHandler: @escaping (_ result:AnyObject?, _ error:Error?)->Void)->URLSessionDataTask? {
    
    if let url = URL(string:urlString) {
      
      let request = URLRequest(url: url)
        
      let task = URLSession.shared.dataTask(with: request) { (data,response, downloadError) in
          
        if let error = downloadError {
          completionHandler(nil, error)
        } else {
          completionHandler(data as AnyObject?, nil)
        }
          
      }
        
      task.resume()
    
      return task
    }
    
    return nil
  }
  
  
  // MARK: - Shared Image Cache
  
  struct Caches {
    static let imageCache = MindValleyCache()
  }

  
  
  
}
