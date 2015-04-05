//
//  PersonCell.swift
//  Turtle
//
//  Created by Pedro Ruíz on 4/1/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell
{
//    @IBOutlet var followButton: UIButton?
    
    @IBOutlet var statusButton: UIButton?
    
    var isFollowing: Bool?
    
    var user: PFUser?
        {
        didSet
        {
            self.configure( )
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib( )
        
        self.isFollowing = false
        
        self.statusButton?.hidden = true
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.isFollowing = false
        
        self.statusButton?.hidden = true
        
        self.textLabel?.text = ""
        
        self.user = nil
    }
    
    func configure()
    {
        println("configure started")
        if let constUser = user
        {
            self.textLabel?.text = constUser.username
            
            //are we following this person?
            println("Checking if we are following the person")
            NetworkManager.sharedInstance.isFollowing(constUser, completionHandler: {
                (isFollowing, error) -> () in
                
                if let constError = error
                {
                    // Alert the user, or otherwise modify the UI
                    println(constError)
                }
                else
                {
                    println(isFollowing)
                    self.isFollowing = isFollowing
                    
                    if isFollowing == true
                    {
                        println("We are following")
                        var image = UIImage(named: "UnfollowButton")
                        self.statusButton?.setImage(image, forState: .Normal)
                    }
                    else
                    {
                        var image = UIImage(named: "FollowButton")
                        self.statusButton?.setImage(image, forState: .Normal)
                    }
                    println("prepare to show button")
                    self.statusButton?.hidden = false
                }
            })
            
                  }
    }
    
    
    @IBAction func didTapFollow(sender: UIButton)
    {
        self.statusButton?.enabled = false
        
        var newValue = !(self.isFollowing == true)

        NetworkManager.sharedInstance.updateFollowValue(newValue, user: self.user!) {
            (error) -> () in

            self.statusButton?.enabled = true
            
            var image = (newValue == true) ? UIImage(named: "UnfollowButton") : UIImage(named: "FollowButton")
            self.statusButton?.setImage(image, forState: .Normal)
            
            self.isFollowing = newValue
        }
    }
    
    
}
