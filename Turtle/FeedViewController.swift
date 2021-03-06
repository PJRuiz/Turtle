//
//  FeedViewController.swift
//  Turtle
//
//  Created by Pedro Ruíz on 4/1/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource
{
    var items = [ ]
    @IBOutlet var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "PostCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "PostCellIdentifier")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.sharedInstance.fetchFeed {
            (objects, error) -> ( ) in
            
            if let constObjects = objects
            {
                self.items = constObjects
                self.tableView?.reloadData( )
            }
            else if let constError = error
            {
               self.showAlert("Unable to fetch Feed")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // How many items am I displaying?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    // Ready to display an item in a cell for a row in a location within a tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellIdentifier") as! PostCell
        var item = items[indexPath.row] as! PFObject
        
        cell.post = item
        return cell
    }
    
}
