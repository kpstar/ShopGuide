//
//  MoreViewController.swift
//  ShopGuide
//
//  Created by KpStar on 2/25/18.
//  Copyright © 2018 Australia. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var slashLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    var index = Int()
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 13/255.0, green: 82/255.0, blue: 87/255.0, alpha: 1)
        imgImage.image = image
        if index == 8 {
            titleLabel.text = "Receipts"
        } else if index == 5 {
            titleLabel.text = "Where is it?"
        } else {
            titleLabel.text = "Price?"
        }
        titleLabel.textColor = UIColor.white
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.index = index
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
