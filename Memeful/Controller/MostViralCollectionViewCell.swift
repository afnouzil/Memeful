//
//  MostViralCollectionViewCell.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/29/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import UIKit

class MostViralCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var imageStackView: UIStackView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
