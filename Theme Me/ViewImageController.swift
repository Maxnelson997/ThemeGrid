//
//  ViewImageControllerViewController.swift
//  Theme Me
//
//  Created by Max Nelson on 7/21/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class ViewImageController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let imView:UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        return i
    }()
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = false
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(image: UIImage?) {
        self.imView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imView)
        
        NSLayoutConstraint.activate([
            imView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imView.topAnchor.constraint(equalTo: view.topAnchor),
            imView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
