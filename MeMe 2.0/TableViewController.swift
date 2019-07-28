//
//  TableViewController.swift
//  MeMe1.0
//
//  Created by Hend  on 6/24/19.
//  Copyright © 2019 Hend . All rights reserved.
//

import UIKit
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    // Get ahold of some memes, for the table
    // This is an array of memes instances
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.memes = (UIApplication.shared.delegate as! AppDelegate).memes
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}

