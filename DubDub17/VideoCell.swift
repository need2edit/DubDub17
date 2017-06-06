//
//  VideoCell.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

open class VideoCell: UICollectionViewCell {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!

    public func updateImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    public func setImageBackgroundColor(_ color: UIColor) {
        self.imageView.backgroundColor = color
    }
    
    public func updateTitle(_ title: String?) {
        self.textLabel.text = title
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 4.0
    }
    
}
