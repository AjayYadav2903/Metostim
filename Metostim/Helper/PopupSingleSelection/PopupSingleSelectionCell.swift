//
//  PopupSingleSelectionCell.swift
//  VSSHR
//
//  Created by admin on 23/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PopupSingleSelectionCell: UITableViewCell {

    @IBOutlet weak var leaveType : UILabel!
    @IBOutlet weak var imgSelectUnselect : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
