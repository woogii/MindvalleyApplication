//
//  ImageListViewController.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ImageListViewController: UICollectionViewController

class ImageListViewController: UICollectionViewController {
  
  // MARK : - Property
  
  var posts = [PostInfo]()
  var isRequesting = false
  var isLastPage = false
  let refreshControl : UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ImageListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addRefreshControl()
    fetchDataFromBundle()
  }
  
  func addRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl = refreshControl
    } else {
      self.collectionView?.addSubview(refreshControl)
    }
    
  }
  
  func handleRefresh(_ refreshControlForCollectionView:UIRefreshControl) {
    initList()
    fetchDataFromBundle()
  }
  
  func initList() {
    posts = []
  }
  
  
  func fetchDataFromBundle() {
    
    if let path = Bundle.main.path(forResource: MindvalleyConstants.ImageListVC.BundleResourceName, ofType: MindvalleyConstants.ImageListVC.FileTypeJSON) {
      
      do {
        
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        
        let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: AnyObject]]
        
        posts = PostInfo.createPostInfoListFromDictionaryArray(dictionaryArray: dictionaryArray!)
        
        DispatchQueue.main.async {
          self.collectionView?.reloadData()
        }
      } catch let err {
        #if DEBUG
          print(err)
        #endif
      }
      
    }
    
  }
  
  func stopRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl?.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
    
  }
  
  // MARK : - ImageListViewController: UICollectionView DataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var post = posts[indexPath.row]
    var bgImage:UIImage? =  UIImage(named: MindvalleyConstants.Image.PlaceHolder)
    var profileImage:UIImage? = UIImage(named:MindvalleyConstants.Image.PlaceHolder)
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MindvalleyConstants.ImageListCollectionViewCell.Identifier, for: indexPath) as! ImageListCollectionViewCell
  
    
    cell.creatorLabel.text = post.userName
    cell.backgroundImageView.image = nil
    cell.profileImageView.image = nil
    
  
    if post.backgroundImage != nil && post.profileImage != nil {
      bgImage = post.backgroundImage
      profileImage = post.profileImage
    } else {
      
      
      let bgImageRequestTask = MindvalleyImage.sharedInstance.requestImageWith(urlString: post.backgroundImageUrlString!, completionHandler: { (result,error) in
        
        if error != nil {
          
        } else {
          
          if let data = result as? Data {
            
            let backgroundImage = UIImage(data:data)
            post.backgroundImage = backgroundImage
            
            
            let profileImageRequestTask = MindvalleyImage.sharedInstance.requestImageWith(urlString: post.profileImageUrlString!, completionHandler: { (result,error) in
            
            
              if let data = result as? Data {
              
                let profileImage = UIImage(data: data)
                post.profileImage = profileImage
              
                DispatchQueue.main.async {
                  cell.backgroundImageView.image = backgroundImage
                  cell.profileImageView.image = profileImage
                }
                
              }
          
            })
            cell.taskToCancelifCellIsReused = profileImageRequestTask
            
          }
        }
      })
      
      cell.taskToCancelifCellIsReused = bgImageRequestTask
      
    }
    
    cell.backgroundImageView.image = bgImage
    cell.profileImageView.image = profileImage
    
    return cell
  }
  
  // MARK: - UIScrollViewDelegate
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    stopRefreshControl()
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if scrollView.contentSize.height > scrollView.frame.size.height {
      
      if scrollView.bounds.origin.y + scrollView.frame.size.height >= scrollView.contentSize.height {
        
        if !isRequesting && !isLastPage {
          
          isRequesting = true
          loadMoreImageList()
        }
        
      }
    }
  }
  
  func loadMoreImageList() {
    
    
    if let path = Bundle.main.path(forResource: MindvalleyConstants.ImageListVC.BundleResourceName, ofType: MindvalleyConstants.ImageListVC.FileTypeJSON) {
      
      do {
        
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        
        let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: AnyObject]]
        
        let addedPosts = PostInfo.createPostInfoListFromDictionaryArray(dictionaryArray: dictionaryArray!)
        
        if addedPosts.count == 0 {
          self.isLastPage = true
          return
        }
        
        self.posts.append(contentsOf: addedPosts)
        
        DispatchQueue.main.async {
          self.collectionView?.reloadData()
          self.isRequesting = false
        }
      } catch let err {
        #if DEBUG
          print(err)
        #endif 
      }
      
    }
    
    
  }
  
  
}

// MARK : - ImageListViewController: UICollectionViewDelegateFlowLayout

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.size.width/MindvalleyConstants.ImageListVC.NumberOfColumns, height: MindvalleyConstants.ImageListCollectionViewCell.ImageListCollectionViewCelllHeight)
    
  }
  
}








