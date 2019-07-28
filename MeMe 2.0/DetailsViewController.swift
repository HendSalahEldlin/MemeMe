//
//  DetailsViewController.swift
//  MeMe1.0
//
//  Created by Hend  on 6/24/19.
//  Copyright © 2019 Hend . All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController,  UINavigationControllerDelegate {
    var meme:Meme!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let meme = self.meme{
            self.imageView.image = meme.memedImage
        }
        
    }
    
}
