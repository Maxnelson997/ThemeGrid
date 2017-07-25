//
//  ImageViewCell.swift
//  Theme Me
//
//  Created by Max Nelson on 7/21/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class imViewCell: UICollectionViewCell {
    
    let imView = UIImageView()
    
    var is_menu_cell:Bool = false

    override func awakeFromNib() {
        imView.frame = contentView.frame
        imView.contentMode = .scaleAspectFill
        
        imView.alpha = 0
    
        if is_menu_cell {
            animate_cell()
            self.isUserInteractionEnabled = false
        } else {
            imView.alpha = 1
        }
        
        contentView.clipsToBounds = true
        contentView.addSubview(imView)
    }
    
    func animate_cell() {
//        print("current tag: \(self.tag)")
        let randomTime = Int(arc4random_uniform(5))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(randomTime), execute: {
            UIView.animate(withDuration: 3, animations: {
                self.imView.alpha = 0
            }, completion: { finished in
                self.imView.image = MainSingleton.sharedInstance.menu_images[self.tag]
                UIView.animate(withDuration: 3, animations: {
                    self.imView.alpha = 1
                }, completion: { finished in
                    self.animate_cell()
                    
                })
                
            })
        })

    }
    
    override func prepareForReuse() {
        imView.removeFromSuperview()
    }
}
