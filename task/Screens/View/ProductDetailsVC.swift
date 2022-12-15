//
//  ProductDetailsVC.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productdesc: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var productI = ""
    var productD = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.loadImageUsingCache(withUrl: productI)
        productdesc.text = productD
    }
}
