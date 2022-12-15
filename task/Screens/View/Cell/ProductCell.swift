//
//  ProductCell.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        nameLabel.text = nil
        salaryLabel.text = nil
        ageLabel.text = nil
    }
}
