//
//  ProductCell.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var imageIV: UIImageView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            imageIV.loadImageUsingCache(withUrl: cellViewModel?.image ?? "")
            imageHeight.constant = cellViewModel?.imageHeight ?? 0
            imageWidth.constant = cellViewModel?.imageWidth ?? 0
            descLabel.text = cellViewModel?.desc
            priceLabel.text = cellViewModel?.price
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageIV.image = nil
        descLabel.text = nil
        priceLabel.text = nil
    }
}
