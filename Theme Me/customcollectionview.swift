//
//  customcollectionview.swift
//  TabBarPRactice
//
//  Created by Max Nelson on 5/6/17.
//  Copyright © 2017 Max Nelson. All rights reserved.
//

import UIKit

class customcollectionview: UICollectionViewController {
    
    let singleton = MainSingleton.sharedInstance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        collectionView?.backgroundColor = .white
        collectionView?.register(imViewCell.self, forCellWithReuseIdentifier: "cvcell")
        collectionView?.register(MenuHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "menu_header")
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
        let image = singleton.images[indexPath.item]
        if image.size.width > 2500 || image.size.height > 2500 {
            cell.imView.image = singleton.resizeImage(image: image, targetSize: CGSize(width: image.size.width*0.1, height: image.size.height*0.1))
        } else {
            cell.imView.image = image
        }
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
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "menu_header", for: indexPath) as! MenuHeader
            header.isGrid = true
            header.awakeFromNib()
            header.sublineText = " The photos you add show up here.\n\n- Tap to view an image and or delete it.\n\n- Hold for a second then drag an image to re-arrange it on your grid.\n\n- Swipe right to view the same grid and pictures as if they were on your Instagram page"
            header.subline.textAlignment = .left
            return header
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        print(singleton.images.count)
        appDelegate.viewImage(image: singleton.images[indexPath.item], index: indexPath.item)
    }
}


extension customcollectionview: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numColumns:CGFloat = 3
        let boxSize = (collectionView.frame.width - (numColumns)) / 3
        return CGSize(width: (boxSize - 40/3), height: (boxSize - 40/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
}
