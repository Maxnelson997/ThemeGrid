//
//  MenuHeader.swift
//  Theme Me
//
//  Created by Max Nelson on 7/24/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class MenuHeader:UICollectionReusableView {
    
    var headline = ITLabel()
    var subline = ITLabel()
    
    var headline_cons:[NSLayoutConstraint]!
    var subline_cons:[NSLayoutConstraint]!
    
    fileprivate lazy var s:UIStackView = {
        let s = UIStackView(arrangedSubviews: [self.headline, self.subline])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        return s
    }()
    
    var active:Bool = false
    var isGrid:Bool = false

    
    override func awakeFromNib() {
        if !active {
//            subline.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            subline.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            subline.layer.masksToBounds = true
            subline.layer.cornerRadius = 8
            active = true
            
            addSubview(s)
            
            headline.textColor = .black
            subline.textColor = .white

            headline.font = UIFont.MNUbuntuTwentyFive
            subline.font = UIFont.MNUbuntuFifteen

            subline.numberOfLines = 15
            
            headline.textAlignment = .center
            subline.textAlignment = .left
            
            var top:CGFloat = 15
            var bottom:CGFloat = -65
            var headline_h:CGFloat = 0
            var subline_h:CGFloat = 1
            if isGrid {
                top = 115
                headline_h = 0
                subline_h = 1
                bottom = -10
            }
            
            
            NSLayoutConstraint.activate([
                s.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                s.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
                s.topAnchor.constraint(equalTo: self.topAnchor, constant: top),
                s.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom),
                headline.heightAnchor.constraint(equalTo: s.heightAnchor, multiplier: headline_h),
                subline.heightAnchor.constraint(equalTo: s.heightAnchor, multiplier: subline_h),
                ])
        }
    }
    
    
    
    
    var headlineText:String {
        get {
            return headline.text!
        }
        set {
            headline.text = newValue
        }
    }
    
    var sublineText:String {
        get {
            return subline.text!
        }
        set {
            subline.text = newValue
        }
    }
    
    override func prepareForReuse() {
        
    }
}


class InstaHeader:UICollectionReusableView {
    let imView = UIImageView()
    
    var active:Bool = false
    override func awakeFromNib() {
        imView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imView)
        if !active {
            active = true
            NSLayoutConstraint.activate([
                imView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                imView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                imView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                imView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                ])
        }
    }
    
    override func prepareForReuse() {
        
    }
}

