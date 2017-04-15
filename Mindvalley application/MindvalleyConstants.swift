//
//  MindvalleyConstants.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


struct MindvalleyConstants {
  
  
  struct JSONResponseKeys {
    
    static let Id         = "user"
    static let CreatedAt  = "created_at"
    static let LikesCount = "likes"
  
    struct UserInfo {
      
      
      static let User   = "user"
      static let Id =  "id"
      static let UserName =  "username"
      static let Name  = "name"
      static let ProfileImage = "profile_image"
      static let ProfileLinks = "links"
      
    }
    
    struct UrlInfo {
      
      static let Urls = "urls"
      static let RawImage = "raw"
      static let SmallImage = "small"
      static let RegularImage = "regular"
      static let ThumbnailImage = "thumb"
    
    }
    
    
    struct CategoryInfo {
      
    }
    
    
  }
}
