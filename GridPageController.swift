//
//  GridPageController.swift
//  Theme Me
//
//  Created by Max Nelson on 7/24/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class GridPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let layout = UICollectionViewFlowLayout()
    let layout1 = UICollectionViewFlowLayout()

    var pageControl = UIPageControl()
    var pageControlBase:UIView = UIView()

    var grid_controller:customcollectionview!
    var insta_grid_controller:InstaViewGrid!
//    var image_controller:ViewImageController!


    var orderedViewControllers:[UIViewController]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl()
        
        layout.minimumLineSpacing = 1.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.scrollDirection = UICollectionViewScrollDirection.vertical

        layout1.minimumLineSpacing = 1.0;
        layout1.minimumInteritemSpacing = 1.0;
        layout1.scrollDirection = UICollectionViewScrollDirection.vertical
        
        grid_controller = customcollectionview(collectionViewLayout: layout)
//        image_controller = ViewImageController(image: #imageLiteral(resourceName: "DSC08777-2"))
        insta_grid_controller = InstaViewGrid(collectionViewLayout: layout1)
        orderedViewControllers = [grid_controller, insta_grid_controller]
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
//        self.pageControl.pageIndicatorTintColor = UIColor(red: 25, green: 61, blue: 99, alpha: 1)
//        self.pageControl.currentPageIndicatorTintColor = UIColor.blue.withAlphaComponent(0.5)
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.gray
//        pageControl.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        pageControl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 8
        self.view.addSubview(pageControlBase)
        self.view.addSubview(pageControl)

        pageControl.frame = CGRect(x: view.frame.midX - 25, y: 75, width: 50, height: 35)

        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
//        self.setViewControllers([grid_controller], direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return nil
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return nil
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        if pageContentViewController == (insta_grid_controller) {
            self.navigationItem.titleView = appDelegate.makeTitle(titleText: "What It Looks Like On Instagram")
            UIView.animate(withDuration: 0.3, animations: {
                self.pageControl.alpha = 0.2
            })
        }
        else if pageContentViewController == (grid_controller) {
            self.navigationItem.titleView = appDelegate.makeTitle(titleText: "Your Grid")
            UIView.animate(withDuration: 0.3, animations: {
                self.pageControl.alpha = 1
            })
        }
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
        
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(pendingViewControllers)

    }
    
    


}
