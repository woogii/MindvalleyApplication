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
  
  let cellHeight:CGFloat = 180
  let cellID = "imageListCollectionViewCell"
  let bundleResourceName = "sampleData"
  let fileTypeJSON = "json"
  var posts = [PostInfo]()
  let refreshControl : UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ImageListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()

  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
    
    if let path = Bundle.main.path(forResource: bundleResourceName, ofType: fileTypeJSON) {
      
      do {
        
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        
        let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: AnyObject]]
        
        print(dictionaryArray as Any)
        
        posts = PostInfo.createPostInfoListFromDictionaryArray(dictionaryArray: dictionaryArray!)
        
        DispatchQueue.main.async {
          self.collectionView?.reloadData()
          self.stopRefreshControl()
        }
      } catch let err {
        print(err)
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageListCollectionViewCell
    
    cell.postInfo = self.posts[indexPath.row]
    return cell
  }

  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    // stopRefreshControl()
  }

}

// MARK : - ImageListViewController: UICollectionViewDelegateFlowLayout

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.size.width/2, height: cellHeight)
    
  }
  
}




  



