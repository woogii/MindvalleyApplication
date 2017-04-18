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
  
//  var postInfo:PostInfo! {
//    didSet {
//      updateCell()
//    }
//  }
  
  var taskToCancelifCellIsReused: URLSessionTask? {
    
    didSet {
      if let taskToCancel = oldValue {
        taskToCancel.cancel()
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyCornerRadiusToBackgroundImageView()
    applyCornerRadiusToProfileImageView()
  
  }
  
  func applyCornerRadiusToBackgroundImageView() {
    backgroundImageView.layer.cornerRadius = MindvalleyConstants.ImageListCollectionViewCell.BackgroundImageViewCornerRadius
    backgroundImageView.layer.masksToBounds = true
  }
  
  func applyCornerRadiusToProfileImageView() {
    profileImageView.layer.cornerRadius = MindvalleyConstants.ImageListCollectionViewCell.ProfileImageViewCornerRadius
    profileImageView.layer.masksToBounds = true
  }
  
}
