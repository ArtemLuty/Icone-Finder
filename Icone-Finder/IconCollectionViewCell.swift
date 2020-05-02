//
//  IconCollectionViewCell.swift
//  Icone Finder
//
//  Created by Корістувач on 01.05.2020.
//  Copyright © 2020 kolesnikov. All rights reserved.
//

import UIKit
import SDWebImage

class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    var icon: Icon? {
        didSet {
            iconLabel.text = icon?.tagsToString()
            if let link = icon?.link, let url = URL(string: link) {
                iconView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet{
            layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0
        layer.backgroundColor = tintColor.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
}
