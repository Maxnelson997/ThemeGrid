//
//  instaViewGrid.swift
//  Theme Me
//
//  Created by Max Nelson on 7/25/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class InstaViewGrid: UICollectionViewController {
    
    let singleton = MainSingleton.sharedInstance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        collectionView?.backgroundColor = .white
        collectionView?.register(imViewCell.self, forCellWithReuseIdentifier: "cvcell")
        collectionView?.register(InstaHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "menu_header")
        //        collectionView?.layer.cornerRadius = 15
        //        collectionView?.layer.masksToBounds = true
        //        collectionView?.layer.borderColor = UIColor.gray.cgColor
        //        collectionView?.layer.borderWidth = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        singleton.download_images {
        //            self.reloadImages()
        //        }
        self.reloadImages()
        
    }
    
    func reloadImages() {
        collectionView?.reloadData()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcell", for: indexPath) as! imViewCell
        
        cell.awakeFromNib()
        cell.imView.image = singleton.images[indexPath.item]
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleton.images.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    var pageControl = UIPageControl()
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = singleton.images.remove(at: sourceIndexPath.item)
        singleton.images.insert(temp, at: destinationIndexPath.item)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "menu_header", for: indexPath) as! InstaHeader
            header.awakeFromNib()
            header.imView.image = #imageLiteral(resourceName: "InstaHeader")
            return header
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.5 + 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        print(singleton.images.count)
        appDelegate.viewImage(image: singleton.images[indexPath.item], index: indexPath.item)
    }
}


extension InstaViewGrid: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numColumns:CGFloat = 3
        let boxSize = (collectionView.frame.width - (numColumns - 1)) / 3
        return CGSize(width: (boxSize), height: (boxSize))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
