//
//  StartViewController.swift
//  Turtle
//
//  Created by Pedro Ruíz on 3/30/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBarHidden = true
//    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSignIn(sender: AnyObject)
    {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authMode = .SignIn
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSignUp(sender: AnyObject)
    {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authMode = .SignUp
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
