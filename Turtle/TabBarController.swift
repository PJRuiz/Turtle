//
//  TabBarController.swift
//  Turtle
//
//  Created by Pedro Ruíz on 3/31/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var feedViewController = FeedViewController(nibName: "FeedViewController", bundle: nil)
        
        var cameraViewController = UIViewController()
        
//        var profileViewController = ProfileViewController(nibName:"ProfileViewController", bundle: nil)
//        profileViewController.user = PFUser.currentUser()
//        
        
        var searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
//        profileViewController,
        
        var albumViewController = UIViewController()
        var viewControllers = [feedViewController, cameraViewController, albumViewController, searchViewController]
        
        self.setViewControllers(viewControllers, animated: true)
//        "ProfileIcon",
        var imageNames = ["FeedIcon", "CameraIcon", "AlbumIcon", "SearchIcon"]
        
        let tabItems = tabBar.items as [UITabBarItem]
        for (index, value) in enumerate(tabItems)
        {
            var imageName = imageNames[index]
            value.image = UIImage(named: imageName)
            value.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0)

        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.hidesBackButton = true
        self.tabBar.translucent = false
        
        self.delegate = self
        
        // Set the Sign Out Button on the top right corner of the navigation bar and define its function afterwards
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .Done, target: self, action: "didTapSignOut:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .Done, target: self, action: nil)
        
        
        
    }
    
    func didTapSearch(sender:AnyObject)
    {
        println("Tapped Search")
    }

    func didTapSignOut(sender: AnyObject)
    {
        PFUser.logOut()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false,animated: false)
        
        self.navigationItem.title = "Turtle"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    {
        var cameraViewController = self.viewControllers![1] as UIViewController
        if viewController == cameraViewController
        {
            showCamera()
            return false
        }
        
        var albumViewController = self.viewControllers![2] as UIViewController
        if viewController == albumViewController
        {
            showAlbum()
            return false
        }
        
        return true
    }
   
    
    func showCamera()
    {
        
        // Camera loads the camera, saved photos album loads the camera roll
        if !UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            self.showAlert("Camera is not available")
            return
        }
        
        var viewController = UIImagePickerController()
        viewController.sourceType = .Camera

        viewController.delegate = self
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        var image: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        var targetWidth = UIScreen.mainScreen().scale * UIScreen.mainScreen().bounds.size.width
        var resizedImage = image.resize(targetWidth)
        
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            
           NetworkManager.sharedInstance.postImage(resizedImage, completionHandler: {
                (error) -> () in
                
                if let constError = error
                {
                    self.showAlert(constError.localizedDescription)
                }
            })
            
        })
    }

    func showAlbum()
    {
        
        if !UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)
        {
            self.showAlert("Camera is not available")
            return
        }
        
        var viewController = UIImagePickerController()
        viewController.sourceType = .SavedPhotosAlbum
        
        viewController.delegate = self
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }

}
