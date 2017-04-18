//
//  ImageCache.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK: - ImageCache 

class MindValleyCache : NSObject {
  
  // MARK: - Property
  
  private var inMemoryCache = NSCache<NSString, DiscardableImageContent>()
  
  override init() {
    super.init()
    setCacheCapacity()
    
  }
  
  func setCacheCapacity() {
    inMemoryCache.countLimit = MindvalleyConstants.MindValleyCache.MaximumCapacity
  }
  
  // MARK: - Retreiving images
  
  func retrieveImage(path: String?) -> UIImage? {
  
    // If the path is nil, or empty, return nil
    if path == nil || path! == "" {
      return nil
    }
    
    // First try the memory cache
    if let data = inMemoryCache.object(forKey: path! as NSString) {
      return data.image 
    }
    
    return nil
  }
  
  // MARK: - Saving images
  
  func storeImage(image: UIImage?, path: String) {
    
    if image == nil {
      inMemoryCache.removeObject(forKey: path as NSString)
      return
    }
    
    let data = DiscardableImageContent(image: image!)
    inMemoryCache.setObject(data, forKey: path as NSString)
    
  }
  
}
