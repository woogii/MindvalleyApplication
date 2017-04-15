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

  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    fetchDataFromBundle()
    
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
        }
      } catch let err {
        print(err)
      }
      
    }

  }

  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageListCollectionViewCell
    
    cell.postInfo = self.posts[indexPath.row]
    return cell
  }


}

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.size.width/2-1, height: cellHeight)
    
  }
  
}

