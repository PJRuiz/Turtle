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
    @IBOutlet var followButton: UIButton?
    
    var isFollowing: Bool?
    
    var user: PFUser?
        {
        didSet
        {
            self.configure()
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.textLabel?.text = ""
        
        self.user = nil
    }
    
    func configure()
    {
        if let constUser = user
        {
            self.textLabel?.text = constUser.username
        }
    }
}
