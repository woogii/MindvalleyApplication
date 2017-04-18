//
//  MindvalleyConstants.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - MindvalleyConstants

struct MindvalleyConstants {
  

  static let requestedImageListSize = 10
  
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
  
  // MARK : - Cell ID
  
  struct ImageListCollectionViewCell {
    static let Identifier = "imageListCollectionViewCell"
    static let BackgroundImageViewCornerRadius:CGFloat = 4
    static let ProfileImageViewCornerRadius:CGFloat = 4
    static let ImageListCollectionViewCelllHeight:CGFloat = 180
  }
  
  
  // MARK : - ImageListVC
  
  struct ImageListVC {
    static let BundleResourceName = "sampleData"
    static let FileTypeJSON = "json"
    static let NumberOfColumns:CGFloat = 2
    static let NumberOfRequestedPostList = 10
  }
  
  struct MindValleyCache {
    static let MaximumCapacity = 1000
  }
  
  struct Image {
    static let PlaceHolder = "placeholder"
  }
}
