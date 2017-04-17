//
//  MindvalleyConstants.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - MindvalleyConstants

struct MindvalleyConstants {
  

  // MARK : - JSON Response Keys
  
  struct JSONResponseKeys {
    
    // MARK : - General Keys 
    
    static let Id         = "user"
    static let CreatedAt  = "created_at"
    static let LikesCount = "likes"
  
    // MARK : - User Information
    
    struct UserInfo {
      
      static let User   = "user"
      static let Id =  "id"
      static let UserName =  "username"
      static let Name  = "name"
      static let ProfileImage = "profile_image"
      static let ProfileLinks = "links"
      
    }
    
    // MARK : - URL Information
    
    struct UrlInfo {
      
      static let Urls = "urls"
      static let RawImage = "raw"
      static let SmallImage = "small"
      static let RegularImage = "regular"
      static let ThumbnailImage = "thumb"
    
    }
    
    // MARK : - Category Information
    
    struct CategoryInfo {
      
    }
    
    
  }
}
