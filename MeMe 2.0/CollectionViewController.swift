//
//  CollectionViewController.swift
//  MeMe1.0
//
//  Created by Hend  on 6/24/19.
//  Copyright © 2019 Hend . All rights reserved.
//

import UIKit
class CollectionViewController:UICollectionViewController {
    
    // MARK: Properties
    
    // TODO: Add outlet to flowLayout here.
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    // Get ahold of some memes, for the table
    // This is an array of meme instances
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Implement flowLayout here.
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.memes = (UIApplication.shared.delegate as! AppDelegate).memes
        collectionView.reloadData()
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
