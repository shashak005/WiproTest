//
//  CanadaTableViewCell.swift
//  WiproTest
//
//  Created by Shashank on 31/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import UIKit

class CanadaTableViewCell: UITableViewCell {
    var imageCanada = UIImageView()
    var labelTitle = UILabel()
    var labelDescription = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let displayWidth: CGFloat = self.frame.width
        labelTitle.frame = CGRect(x: 90, y: 0, width: displayWidth - 90, height: 30)
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelDescription.numberOfLines = 0
        labelDescription.textColor = UIColor.blue
        imageCanada.frame = CGRect(x: 5, y: 10, width: 70, height: 70)
        imageCanada.layer.borderWidth = 1
        self.addSubview(labelTitle)
        self.addSubview(labelDescription)
        self.addSubview(imageCanada)
    }
   
}
