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
    var items = []
    @IBOutlet var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "PostCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "PostCellIdentifier")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // How many items am I displaying?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    // Ready to display an item in a cell for a row in a location within a tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellIdentifier") as PostCell
        var item = items[indexPath.row] as PFObject
        
        cell.item = item
        return cell
    }
    
}
