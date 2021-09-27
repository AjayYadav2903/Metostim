//
//  LeftSlideTableViewCell.swift
//  AirVting
//
//  Created by Admin on 7/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class LeftSlideTableViewCell: UITableViewCell {
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var notiMessage: UILabel!
    @IBOutlet weak var notiView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
