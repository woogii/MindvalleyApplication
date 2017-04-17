//
//  ImageListCollectionViewCell.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ImageListCollectionViewCell: UICollectionViewCell

class ImageListCollectionViewCell: UICollectionViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var creatorLabel: UILabel!
  
  var postInfo:PostInfo! {
    didSet {
      updateCell()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyCornerRadiusToBackgroundImageView()
    applyCornerRadiusToProfileImageView()
  
  }
  
  func applyCornerRadiusToBackgroundImageView() {
    backgroundImageView.layer.cornerRadius = 4
    backgroundImageView.layer.masksToBounds = true
  }
  
  func applyCornerRadiusToProfileImageView() {
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
    profileImageView.layer.masksToBounds = true
  }
  
  func setCreatorLabel() {
    creatorLabel.text = postInfo.userName
  }
  
  func updateCell() {
    
    setCreatorLabel()

    MindvalleyImage.sharedInstance.requestImageWith(urlString: postInfo.backgroundImageUrlString!, completionHandler: { (result,error) in
      
      if error != nil {
        
      } else {

        if let data = result as? Data {
          
          let backgroundImage = UIImage(data: data)
          
          MindvalleyImage.sharedInstance.requestImageWith(urlString: self.postInfo.profileImageUrlString, completionHandler: { (result,error) in
            
        
            if let data = result as? Data {
          
              let profileImage = UIImage(data: data)
              
              DispatchQueue.main.async {
                
                self.backgroundImageView.image = backgroundImage
                self.profileImageView.image = profileImage
              }
            
              
            }
          })
          
          
          
        }
        
        
        
        
        
      }
    })
    
  }
}
