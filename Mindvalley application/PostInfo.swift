//
//  PostInfo.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

struct PostInfo {
  
  var userName:String?
  var profileImageUrlString:String?
  var backgroundImageUrlString:String?
  
  var backgroundImage: UIImage? {
    get {
      return MindvalleyImage.Caches.imageCache.retrieveImage(path: backgroundImageUrlString)
    }
    
    set {
      MindvalleyImage.Caches.imageCache.storeImage(image: newValue, path: backgroundImageUrlString!)
    }
  }

  var profileImage: UIImage? {
    get {
      return MindvalleyImage.Caches.imageCache.retrieveImage(path: profileImageUrlString)
    }
    
    set {
      MindvalleyImage.Caches.imageCache.storeImage(image: newValue, path: profileImageUrlString!)
    }
  }
  
  init(userName:String, profileImageUrlString:String, backgroundImageUrlString:String) {
    
    self.userName = userName
    self.profileImageUrlString = profileImageUrlString
    self.backgroundImageUrlString = backgroundImageUrlString
    
  }
  
  static func createPostInfoListFromDictionaryArray(dictionaryArray:[[String:AnyObject]])-> [PostInfo] {
 
    var postInfoArray = [PostInfo]()
    
    for dict in dictionaryArray {
      
      guard let userInfo = dict[MindvalleyConstants.JSONResponseKeys.UserInfo.User] as? [String:AnyObject], let profileImageInfo = userInfo[MindvalleyConstants.JSONResponseKeys.UserInfo.ProfileImage] as? [String:AnyObject],let backgroundImageInfo = dict[MindvalleyConstants.JSONResponseKeys.UrlInfo.Urls] as? [String:AnyObject] else {
        return postInfoArray
      }
    
      let userName = userInfo[MindvalleyConstants.JSONResponseKeys.UserInfo.UserName] as? String
      let profileImageUrlString = profileImageInfo[MindvalleyConstants.JSONResponseKeys.UrlInfo.SmallImage] as? String
      let backgroundImageUrlString = backgroundImageInfo[MindvalleyConstants.JSONResponseKeys.UrlInfo.ThumbnailImage] as? String
      
      let postInfo = PostInfo(userName: userName ?? "", profileImageUrlString: profileImageUrlString ?? "", backgroundImageUrlString: backgroundImageUrlString ?? "")
      
      postInfoArray.append(postInfo)
    }
    
    return postInfoArray
  }
  
  
}
