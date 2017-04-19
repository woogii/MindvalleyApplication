//
//  PostInfo.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - PostInfo

struct PostInfo {
  
  // MARK : - Property 
  
  var userName:String?
  var profileImageUrlString:String?
  var backgroundImageUrlString:String?
  var numberOfLikes:Int?
  var timeInfo:String?
  
  
  // MARK : - Computed Property For Background Image Caching
  
  var backgroundImage: UIImage? {
    get {
      return MindvalleyImage.Caches.imageCache.retrieveImage(path: backgroundImageUrlString)
    }
    
    set {
      MindvalleyImage.Caches.imageCache.storeImage(image: newValue, path: backgroundImageUrlString!)
    }
  }

  // MARK : - Computed Property For Profile Image Caching
  
  var profileImage: UIImage? {
    get {
      return MindvalleyImage.Caches.imageCache.retrieveImage(path: profileImageUrlString)
    }
    
    set {
      MindvalleyImage.Caches.imageCache.storeImage(image: newValue, path: profileImageUrlString!)
    }
  }
  
  // MARK : - Initialization 
  
  init(userName:String, profileImageUrlString:String, backgroundImageUrlString:String, numberOfLikes:Int, timeInfo:String) {
    
    self.userName = userName
    self.profileImageUrlString = profileImageUrlString
    self.backgroundImageUrlString = backgroundImageUrlString
    self.numberOfLikes = numberOfLikes
    self.timeInfo = timeInfo
  
  }
  
  // MARK : - Create Model Array
  
  static func createPostInfoListFromDictionaryArray(dictionaryArray:[[String:AnyObject]])-> [PostInfo] {
 
    var postInfoArray = [PostInfo]()
    
    for dict in dictionaryArray {
      
      guard let userInfo = dict[Constants.JSONResponseKeys.UserInfo.User] as? [String:AnyObject], let profileImageInfo = userInfo[Constants.JSONResponseKeys.UserInfo.ProfileImage] as? [String:AnyObject],let backgroundImageInfo = dict[Constants.JSONResponseKeys.UrlInfo.Urls] as? [String:AnyObject] else {
        return postInfoArray
      }
    
      let userName = userInfo[Constants.JSONResponseKeys.UserInfo.UserName] as? String
      let profileImageUrlString = profileImageInfo[Constants.JSONResponseKeys.UrlInfo.SmallImage] as? String
      let backgroundImageUrlString = backgroundImageInfo[Constants.JSONResponseKeys.UrlInfo.ThumbnailImage] as? String
      let numberOfLikes = dict[Constants.JSONResponseKeys.LikesCount] as? Int
      let timeInfo = dict[Constants.JSONResponseKeys.CreatedAt] as? String
      
      let postInfo = PostInfo(userName: userName ?? "", profileImageUrlString: profileImageUrlString ?? "", backgroundImageUrlString: backgroundImageUrlString ?? "", numberOfLikes: numberOfLikes ?? 0,
                              timeInfo: timeInfo ?? "")
      
      postInfoArray.append(postInfo)
    }
    
    return postInfoArray
  }
  
  
}
