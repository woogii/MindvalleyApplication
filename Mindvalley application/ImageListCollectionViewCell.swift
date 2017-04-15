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
  
  
  func updateCell() {
    
    creatorLabel.text = postInfo.userName
    
    MindvalleyImage.sharedInstance.requestImageWith(urlString: postInfo.backgroundImageUrlString!, completionHandler: { (result,error) in
      
      if error != nil {
        
      } else {

        DispatchQueue.main.async {
          
          if let data = result as? Data {
            if let image = UIImage(data: data) {
              self.backgroundImageView.image = image
            }
          }
        }
      }
    })
    
  }
}
