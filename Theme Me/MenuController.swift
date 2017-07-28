




//
//  ViewController.swift
//  Theme Me
//
//  Created by Max Nelson on 7/21/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class MainMenuController: UICollectionViewController {
    
    let singleton = MainSingleton.sharedInstance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        collectionView?.backgroundColor = .white
        collectionView?.register(imViewCell.self, forCellWithReuseIdentifier: "cvcell")
        collectionView?.register(MenuHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: "menu_header")
        collectionView?.isScrollEnabled = false
//        collectionView?.layer.cornerRadius = 15
//        collectionView?.layer.masksToBounds = true
//        collectionView?.layer.borderColor = UIColor.gray.cgColor
//        collectionView?.layer.borderWidth = 6
    
        //        cv.register(cert_header.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "certheader")
        //swap images
        
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: {
        //randomize the array every 0.75 seconds
        self.shuf()
        
    }
    
    
    func shuf() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6
            , execute: {
                //randomize the array every 0.75 seconds
                self.singleton.menu_images.shuffle()
                self.shuf()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        singleton.download_images {
        //            self.reloadImages()
        //        }
        //        self.reloadImages()
    }
    
    func reloadImages() {
        collectionView?.reloadData()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcell", for: indexPath) as! imViewCell
        cell.tag = indexPath.item
        cell.is_menu_cell = true
        cell.awakeFromNib()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return singleton.menu_images.count
        return 6
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

//    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let temp = singleton.menu_images.remove(at: sourceIndexPath.item)
//        singleton.menu_images.insert(temp, at: destinationIndexPath.item)
//    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionFooter:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "menu_header", for: indexPath) as! MenuHeader
            header.awakeFromNib()
            header.headlineText = "Theme Grid"
            header.sublineText = "Plan your Insta theme with an interactive grid.\n\nThe purpose of this app is to simply give you a visual idea of what your pictures look like aside eachother.\n\nThis will help you decided in what order to post pictures on Instagram so you can maintain a solid theme.\n\nTap \"Add To Grid\" below to add a photo to your grid and get started."
            return header
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.5)
    }
    
    
    
}


extension MainMenuController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numColumns:CGFloat = 3
        let boxSize = (collectionView.frame.width - (numColumns)) / 3
        return CGSize(width: (boxSize - 40/3), height: (boxSize - 40/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
