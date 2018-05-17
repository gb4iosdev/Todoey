//
//  GBTableViewCell.swift
//  Todoey
//
//  Created by Gavin Butler on 2018-05-08.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit

class GBTableViewCell: UITableViewCell {
    
    let gradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell () {
        gradientLayer.frame = bounds
        
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor
        let color3 = UIColor.clear.cgColor
        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor
        
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.2,0.8, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}
