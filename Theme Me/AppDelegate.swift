//
//  AppDelegate.swift
//  Theme Me
//
//  Created by Max Nelson on 7/21/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit
import CoreData
import Font_Awesome_Swift
extension UIFont {
    //        Ubuntu
    //        == Ubuntu-Italic
    //        == Ubuntu-Regular
    //        == Ubuntu-Bold
    //        == Ubuntu-MediumItalic
    //        == Ubuntu-Light
    //        == Ubuntu-Medium
    //        == Ubuntu-LightItalic
    open class var MNUbuntuFifteen: UIFont { return UIFont(name: "Ubuntu-Regular", size: 15)! }
    open class var MNUbuntuTwenty: UIFont { return UIFont(name: "Ubuntu-Regular", size: 20)! }
    open class var MNUbuntuTwentyFive: UIFont { return UIFont(name: "Ubuntu-Regular", size: 25)! }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    var window: UIWindow?
    var userPageNavController:UINavigationController!
    let singleton = MainSingleton.sharedInstance
    var indexOfImageBeingViewed:Int!
    
    func makeTitle(titleText:String) -> UIButton {
        let navTitle = UIButton(type: .custom)
        navTitle.setTitle(titleText, for: .normal) 
        navTitle.titleLabel?.font = UIFont.MNUbuntuTwenty
        navTitle.setTitleColor(UIColor.white, for: .normal)
        return navTitle
    }
    func viewImage(image:UIImage, index:Int) {
        indexOfImageBeingViewed = index
        imageController = ViewImageController(image:image)
        imageController.navigationItem.titleView = makeTitle(titleText: "Image View")
        imageController.navigationItem.leftBarButtonItem = back_btn_item
        imageController.navigationItem.rightBarButtonItem = delete_btn_item
        userPageNavController.pushViewController(imageController, animated: true)
    }
    func goToGrid() {
        
        //pop any views that are being shown. Only one possible showing
        for _ in 0 ..< userPageNavController.viewControllers.count {
            userPageNavController.popViewController(animated: true)
        }
        tab_controller.selectedIndex = 2
      //  userPageNavController.pushViewController(userImagesGrid, animated: true)
    }
    func deleteImgAndPop() {
        for _ in 0 ..< userPageNavController.viewControllers.count {
            userPageNavController.popViewController(animated: true)
        }
        singleton.images.remove(at: indexOfImageBeingViewed)
    }
    var tab_controller:UITabBarController!
    var userImagesGrid:UICollectionViewController!
    var imageController:UIViewController!
    //
    var normalViewNav:UINavigationController!
    var camera_nav:UINavigationController!
    //
    var back_btn_item:UIBarButtonItem!
    var delete_btn_item:UIBarButtonItem!
    var page:GridPageController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        for family: String in UIFont.familyNames
        {
//            if family.contains("") {
                print("\(family)")
                for names: String in UIFont.fontNames(forFamilyName: family)
                {
                    print("== \(names)")
                }
//            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        //singleton.setupCognito()
        
        //snag images from core data
        singleton.get_images_coredata()
        
//        let home_image = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        home_image.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal)
//        
//        let camera_image = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        camera_image.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
//        
//        let grid_image = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        grid_image.image = #imageLiteral(resourceName: "layout").withRenderingMode(.alwaysOriginal)
//        
        tab_controller = UITabBarController()
        
        let viewc = MainMenuController(collectionViewLayout: layout)
        normalViewNav = UINavigationController(rootViewController: viewc)
        normalViewNav.tabBarItem.title = "Welcome"

        normalViewNav.tabBarItem.setFAIcon(icon: FAType.FAHome)
//        normalViewNav.tabBarItem.image = resizeImage(image: home_image.image!, targetSize: CGSize(width: 25, height: 25))
        viewc.navigationItem.titleView = makeTitle(titleText: "Theme Grid")
               normalViewNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.MNUbuntuFifteen], for: .normal) 
        let camera_controller = CameraController()
        camera_nav = UINavigationController(rootViewController: camera_controller)
        camera_nav.tabBarItem.title = "Add To Grid"

//        camera_nav.tabBarItem.image = resizeImage(image: camera_image.image!, targetSize: CGSize(width: 25, height: 25))\
        camera_nav.tabBarItem.setFAIcon(icon: FAType.FAPlusSquare)
        camera_controller.navigationItem.titleView = makeTitle(titleText: "Add Image")
        page = GridPageController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                camera_nav.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.MNUbuntuFifteen], for: .normal)
        userPageNavController = UINavigationController()
        userPageNavController.tabBarItem.setFAIcon(icon: FAType.FAThLarge)
//        userPageNavController.tabBarItem.image = resizeImage(image: grid_image.image!, targetSize: CGSize(width: 25, height: 25))
        userPageNavController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.MNUbuntuFifteen], for: .normal)
        
        let back_btn = UIButton(type: .custom)
        back_btn.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        back_btn.contentHorizontalAlignment = .left
        back_btn.setFAIcon(icon: FAType.FAArrowLeft, iconSize: 30, forState: UIControlState.normal)
        back_btn.addTarget(userPageNavController, action: #selector(self.userPageNavController.popViewController(animated:)), for: .touchUpInside)
        back_btn_item = UIBarButtonItem(customView: back_btn)
        
        let delete_btn = UIButton(type: .custom)
        delete_btn.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        delete_btn.contentHorizontalAlignment = .left
        delete_btn.setFAIcon(icon: FAType.FAEllipsisH, iconSize: 30, forState: UIControlState.normal)
        delete_btn.addTarget(self, action: #selector(self.deleteImgAndPop), for: .touchUpInside)
        delete_btn_item = UIBarButtonItem(customView: delete_btn)

        
        imageController = ViewImageController()
        
        
//        userPageNavController.edgesForExtendedLayout = .left
//        
//        
//        userPageNavController.view.backgroundColor = .blue
        UIApplication.shared.statusBarStyle = .default
//        UINavigationBar.appearance().barTintColor = UIColor.darkGray.withAlphaComponent(0.5)
        UINavigationBar.appearance().barTintColor = UIColor.black
        
       


        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
//        userImagesGrid = customcollectionview(collectionViewLayout: layout)
//        userImagesGrid.navigationItem.titleView = makeTitle(titleText: "Theme Layout")
        
//
        userPageNavController.viewControllers = [page]
        userPageNavController.tabBarItem.title = "Grid"
        page.navigationItem.titleView = makeTitle(titleText: "Theme Grid")
        
        tab_controller.viewControllers = [normalViewNav, camera_nav, userPageNavController]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tab_controller
        
        
        normalViewNav.isNavigationBarHidden = false
        camera_nav.isNavigationBarHidden = false
        userPageNavController.isNavigationBarHidden = false

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        singleton.set_images_coredata()
        
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Theme_Me")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

