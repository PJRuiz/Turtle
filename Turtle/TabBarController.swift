//
//  TabBarController.swift
//  Turtle
//
//  Created by Pedro Ruíz on 3/31/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var feedViewController = FeedViewController(nibName: "FeedViewController", bundle: nil)
        
        var cameraViewController = UIViewController()
        cameraViewController.view.backgroundColor = UIColor.purpleColor()
        
        var profileViewController = ProfileViewController(nibName:"ProfileViewController", bundle: nil)
        profileViewController.view.backgroundColor = UIColor.yellowColor()
        
        var searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        
        var viewControllers = [feedViewController, cameraViewController, profileViewController, searchViewController]
        
        self.setViewControllers(viewControllers, animated: true)
        
        var imageNames = ["FeedIcon", "CameraIcon", "ProfileIcon", "SearchIcon"]
        
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
        
        // Set the Sign Out Button on the top right corner of the navigation bar and define its function afterwards
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .Done, target: self, action: "didTapSignOut:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .Done, target: self, action: nil)
        
        
        
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
        // Dispose of any resources that can be recreated.
    }
    


}
