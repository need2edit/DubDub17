//
//  VideoCell.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 4.0
    }
    
}
