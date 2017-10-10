//
//  RowaterCell.swift
//  OznerGPRS
//
//  Created by macpro on 2017/10/10.
//  Copyright © 2017年 macpro. All rights reserved.
//

import UIKit

class RowaterCell: UITableViewCell {

    @IBOutlet weak var keyName: UILabel!
    @IBOutlet weak var valueLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadUI(_ models:ValuesModel) {
        
        keyName.text = models.key
        valueLb.text = String(describing: (models.value))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
