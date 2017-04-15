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
    open static let dataCache = NSCache<NSString,DiscardableDataContent>()
  
    // MARK : - Properties
    
    func requestImageWith(urlString: String, completionHandler:@escaping (_ result:AnyObject?, _ error:Error?)->Void) {
      
      guard let url = URL(string:urlString) else {
        return
      }
      
      let urlStringKey = urlString as NSString
      
      if let cachedData = MindvalleyImage.dataCache.object(forKey: urlStringKey) {
        completionHandler(cachedData as AnyObject?, nil)
        return 
      }
    
      let request = URLRequest(url: url)
      
      _ = URLSession.shared.dataTask(with: request) { (data,response, downloadError) in
        
        if let error = downloadError {
          completionHandler(nil, error)
        } else {
          
          let cacheItem = DiscardableDataContent(data: data!)
          MindvalleyImage.dataCache.setObject(cacheItem, forKey: urlStringKey)
          completionHandler(data as AnyObject?, nil)
          
        }
      }.resume()
      
    
    }
    
  

  
  
  
}
