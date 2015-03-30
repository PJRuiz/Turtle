//
//  AuthViewController.swift
//  Turtle
//
//  Created by Pedro Ruíz on 3/30/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField?
    
    @IBOutlet var passwordTextField: UITextField?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        var emailImageView = UIImageView(frame: CGRectMake(0,0,50, self.emailTextField!.frame.size.height))
        emailImageView.image = UIImage(named: "EmailIcon")
        emailImageView.contentMode = .Center
        
        self.emailTextField!.leftView = emailImageView
        self.emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0,0,50, self.emailTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        self.passwordTextField!.leftView = passwordImageView
        self.passwordTextField!.leftViewMode = .Always        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController!.setNavigationBarHidden(false, animated: false)
    }
    
    
    // Make the keyboard appear automatically by using become first responder
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.emailTextField?.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
