//
//  MainSingleton.swift
//  Theme Me
//
//  Created by Max Nelson on 7/21/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit
//import AWSS3
//import AWSCognito
import CoreData
extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
class MainSingleton {
    
    var appDelegate:AppDelegate!
    static let sharedInstance = MainSingleton()
    var context:NSManagedObjectContext!
    
    private init() {}
    
    let dev = UIDevice.current
    var directory_name_for_user:String!
    var images:[UIImage] = []
    var menu_images: [UIImage] = [#imageLiteral(resourceName: "noskate"), #imageLiteral(resourceName: "centerbig"), #imageLiteral(resourceName: "cattoo"), #imageLiteral(resourceName: "graycomp"), #imageLiteral(resourceName: "maxgray"), #imageLiteral(resourceName: "gwagon"),#imageLiteral(resourceName: "centersmall") ,#imageLiteral(resourceName: "maxlegendary")]//, #imageLiteral(resourceName: "DSC08724-2"), #imageLiteral(resourceName: "DSC08772"), #imageLiteral(resourceName: "DSC08724-2")]
    
    var image_count:Int {
        get {
            return images.count
        }
        set {
            self.image_count = newValue
        }
    }
    
    var imgCount:Int = 0
    
    func get_images_coredata() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request)
            
            if results.count != 0 {
                //count exists
                for result in results as! [NSManagedObject]{
                    //snatch the count
                    
                    if let count = result.value(forKey: "image") as? Data {
                        print("image retrieved: \(count)")
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: count) as? NSArray{
                            //extract data..
                            //                        print("count retrieved: \(Int(count))")
                            for imgData in mySavedData {
                                let img = UIImage(data: imgData as! Data)
                                images.append(img!)
                                
                            }
                        }
                        
                        
                        
                    }
                }
            } else {
                print("count not saved in Core Data")
            }
        }
        catch
        {
            print("hmm error retreiving image count")
        }
    }
    
    var CDataImageArray = NSMutableArray()
    
    func set_images_coredata() {
        var image_count_coredata:NSManagedObject!
        
        //check if count exists
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        
        request.returnsObjectsAsFaults = false
        if let results = try? context.fetch(request) {
            
            if results.count != 0 {
                //a count exists
                image_count_coredata = results.first as! NSManagedObject
            } else {
                //create a count
                image_count_coredata = NSEntityDescription.insertNewObject(forEntityName: "Images", into: context)
            }
        } else {
            //failed
            print("hmm failed?")
        }
        for img in images {
            var compRatio:CGFloat = 1
            if img.size.width > 2500 || img.size.height > 2500 {
                //slightly compress a bit
                compRatio = 0.2
            }
            let data:NSData = NSData(data: UIImageJPEGRepresentation(img, compRatio)!)
            CDataImageArray.add(data)
        }
        let coreDataObject = NSKeyedArchiver.archivedData(withRootObject: CDataImageArray)
        image_count_coredata.setValue(coreDataObject, forKey: "image")
        //store new count

        do
        {
            try context.save()
            print("image count saved in Core Data model: \(String(describing: image_count_coredata.value(forKey: "image")!))")
        }
        catch
        {
            print("hmm error saving credentials")
        }
//                appDelegate.saveContext()
        
    }
    
    //    func setupCognito() {
    //        let cognitoIdentityPoolId = "us-west-2:eff4ffc3-b303-4cd8-9bc0-f496b4b002c0"//"us-west-2_av3wDxJ3P"
    //        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USWest2, identityPoolId: cognitoIdentityPoolId)
    //        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
    //        AWSS3TransferUtility.register(with: configuration!, forKey: "USWest2S3TransferUtility")
    //
    //        //additional setup
    //        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //        directory_name_for_user = dev.model
    //    }
    
    //    func upload_image(imageURL:NSURL) {
    //        let S3BucketName = "theme-me-image-bucket"
    //        let S3UploadKeyName: String = "\(directory_name_for_user!)/image#\(image_count).PNG"
    //        let expression = AWSS3TransferUtilityUploadExpression()
    //
    //        let uploadCompletionHandler:AWSS3TransferUtilityUploadCompletionHandlerBlock = { (task, error) -> Void in
    //            DispatchQueue.main.async(execute: {
    //                if ((error) != nil){
    //                    print("Error: \(error!)");
    //                    print("\n\ntask:\(task)")
    //                }
    //                else{
    //                    print("Success")
    //                    //succesfully uploaded, download it now.
    //                    self.imgCount = self.image_count + 1
    //                    self.update_coredata_image_count()
    //                }
    //            })
    //        }
    //
    //        let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: "USWest2S3TransferUtility")
    //
    //        transferUtility.uploadFile(imageURL as URL, bucket: S3BucketName, key: S3UploadKeyName, contentType: "image/png", expression: expression, completionHandler: uploadCompletionHandler).continueWith { (task) -> AnyObject! in
    //            if let error = task.error {
    //                print("Error: \(error.localizedDescription)")
    //                print("\naaanddd the whole error:\n\(error)")
    //            }
    //            if let _ = task.result {
    //                print("Upload Starting!")
    //            }
    //            return nil
    //        }
    //    }
    //
    //    func update_coredata_image_count() {
    //        var image_count_coredata:NSManagedObject!
    //
    //        //check if count exists
    //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Count")
    //
    //        request.returnsObjectsAsFaults = false
    //        if let results = try? context.fetch(request) {
    //            if results.count != 0 {
    //                //a count exists
    //                image_count_coredata = results.first as! NSManagedObject
    //            } else {
    //                //create a count
    //                image_count_coredata = NSEntityDescription.insertNewObject(forEntityName: "Count", into: context)
    //            }
    //        } else {
    //            //failed
    //            print("hmm failed?")
    //        }
    //
    //        image_count_coredata.setValue(imgCount, forKey: "count")
    //        //store new count
    //
    //        do
    //        {
    //            try context.save()
    //            print("image count saved in Core Data model: \(String(describing: image_count_coredata.value(forKey: "Count")!))")
    //        }
    //        catch
    //        {
    //            print("hmm error saving credentials")
    //        }
    //    }
    //
    //    func get_coredata_image_count() -> Int {
    //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Count")
    //        request.returnsObjectsAsFaults = false
    //        do
    //        {
    //            let results = try context.fetch(request)
    //
    //            if results.count != 0 {
    //                //count exists
    //                for result in results as! [NSManagedObject]{
    //                    //snatch the count
    //                    if let count = result.value(forKey: "count") as? Int16 {
    //                        print("count retrieved: \(Int(count))")
    //                        return Int(count)
    //                    }
    //                }
    //            } else {
    //                print("count not saved in Core Data")
    //                return 0
    //            }
    //        }
    //        catch
    //        {
    //            print("hmm error retreiving image count")
    //            return 0
    //        }
    //        return 0
    //    }
    //
    //    //download image
    //    func download_images(completion: @escaping () -> Void) {
    //        let amt_to_download = get_coredata_image_count()
    //
    //        for i in 0 ..< amt_to_download {
    //            //go through the amount of images ie: the count retrieved from core data and download images from amazon web services 3
    //            download_image(index: i, completion: {
    //                if i == amt_to_download-1 {
    //                    //all images retrieved, call completion/reload the cv.
    //                    completion()
    //                }
    //            })
    //        }
    //    }
    //
    //    func download_image(index:Int, completion: @escaping () -> Void) {
    //        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    //
    //        let S3BucketName = "theme-me-image-bucket"
    //        let S3DownloadKeyName: String = "\(directory_name_for_user!)/image#\(index).PNG"
    //
    //        let expression = AWSS3TransferUtilityDownloadExpression()
    //
    //        completionHandler = { (task, location, data, error) -> Void in
    //            DispatchQueue.main.async(execute: {
    //                if ((error) != nil){
    //                    print("Failed with error")
    //                    print("Error: \(error!)")
    //                }
    //                else{
    //                    //Set your image
    //                    print("Image Retrieved From Amazon Web Service Bucket.")
    //                    let downloadedImage = UIImage(data: data!)
    //                    self.images.append(downloadedImage!)
    //                    completion()
    //                }
    //            })
    //        }
    //
    //        let transferUtility = AWSS3TransferUtility.default()
    //        transferUtility.downloadData(fromBucket: S3BucketName, key: S3DownloadKeyName, expression: expression, completionHandler: completionHandler).continueWith { (task) -> AnyObject! in
    //            if let error = task.error {
    //                print("Error: \(error.localizedDescription)")
    //            }
    //            if let _ = task.result {
    //                print("Download Starting!")
    //            }
    //            return nil;
    //        }
    //    }
    //
    //
    //    //delete image
    //    func delete_image() {
    //        //        let s3 = AWSS3.defaultS3()
    //        //        let deleteObjectRequest = AWSS3DeleteObjectRequest()
    //        //        deleteObjectRequest.bucket = "theme-me-image-bucket"
    //        //        deleteObjectRequest.key = "yourFileName"
    //        //        s3.deleteObject(deleteObjectRequest).continueWithBlock { (task:AWSTask) -> AnyObject? in
    //        //            if let error = task.error {
    //        //                print("Error occurred: \(error)")
    //        //                return nil
    //        //            }
    //        //            print("Deleted successfully.")
    //        //            return nil
    //        //        }
    //    }
    
    
    
    //
    //        let syncClient = AWSCognito.default()
    //
    //        // Create a record in a dataset and synchronize with the server
    //        var dataset = syncClient.openOrCreateDataset("myDatasetTwo")
    //        dataset.setString("myValue", forKey:"myKey")
    //
    //        dataset.synchronize().continueWith {(task: AWSTask!) -> AnyObject! in
    //            // Your handler code here
    //
    //            print("wassup")
    //            print(task)
    //            print("end of cognito setup")
    //            return nil
    //            
    //        }
    
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
}
