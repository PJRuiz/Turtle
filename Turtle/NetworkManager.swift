//
//  NetworkManager.swift
//  Turtle
//
//  Created by Pedro Ruíz on 3/31/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import Foundation

typealias ObjectsCompletionHandler = (objects:[AnyObject]?, error: NSError?) -> ( )

typealias ImageCompletionHandler = (image:UIImage?, error: NSError?) -> ( )


public class NetworkManager
{
    public class var sharedInstance: NetworkManager
    {
        struct Singleton
        {
            static let instance = NetworkManager()
        }
        
        return Singleton.instance
    }
    
    func follow(user: PFUser!, completionHandler:(error: NSError?) -> ( ) )
    {
        var relation = PFUser.currentUser().relationForKey("following")
        
        relation.addObject(user)
        
        PFUser.currentUser().saveInBackgroundWithBlock { (
            success, error) -> Void in
            
            completionHandler(error: error)
        }
        
    }
    
    func fetchFeed(completionHandler: ObjectsCompletionHandler!)
    {
        var relation = PFUser.currentUser().relationForKey("following")
        var query = relation.query()
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
        
            if let constError = error
            {
                println("error fetching following")
                completionHandler(objects: nil, error: constError)
            }
            else
            {
                var postQuery = PFQuery(className: "Post")
                postQuery.whereKey("User", containedIn: objects)
                postQuery.orderByDescending("createdAt")
                postQuery.findObjectsInBackgroundWithBlock(
                    { (objects: [AnyObject]!, error: NSError!) -> Void in
                  
                        completionHandler(objects: objects, error: error)
                    
                    } )
            }
        }
    }
    
    func fetchImage(post: PFObject!, completionHandler: ImageCompletionHandler!)
    {
        var imageReference = post["Image"] as PFFile
        
        imageReference.getDataInBackgroundWithBlock {
            (data, error) -> Void in
            
            if let constError = error
            {
                println("Error fetching image \(constError.localizedDescription)")
                
                completionHandler(image: nil, error: constError)
            }
            else
            {
                println( "we downloaded the image!")
                
                let image = UIImage(data: data)
                
                completionHandler(image:image, error: nil)
            }
        }
    }
}