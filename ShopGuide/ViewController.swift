//
//  ViewController.swift
//  ShopGuide
//
//  Created by KpStar on 2/22/18.
//  Copyright © 2018 Australia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    let menu_images: [UIImage] = [
        UIImage(named: "find_product")!,
        UIImage(named: "find_price")!,
        UIImage(named: "promotion")!,
        UIImage(named: "loyalty")!,
        UIImage(named: "StoreMap")!,
        UIImage(named: "ShoppingList")!,
        UIImage(named: "Stores")!,
        UIImage(named: "toilet")!,
        UIImage(named: "receipt")!,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 13/255.0, green: 82/255.0, blue: 87/255.0, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsetsMake(10,10,10,10)
//        layout.minimumLineSpacing = 20
//        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width-20)/3,height:(self.collectionView.frame.size.width-20)/3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu_images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cgsize = CGSize(width: (self.collectionView.frame.size.width-50)/3, height: (self.collectionView.frame.size.width-50)/3)
        return cgsize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.menu_imageview.image = menu_images[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.image = menu_images[indexPath.row]
        desVC.index = indexPath.row
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
}



