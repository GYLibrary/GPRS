//
//  WaterPurifiCell.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/22.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/22  下午1:24
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class WaterPurifiCell: UITableViewCell {

    
    @IBOutlet weak var powerBtn: UIButton!
    
    @IBOutlet weak var hotBnt: UIButton!
    
    @IBOutlet weak var coldBtn: UIButton!
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        appDelegate.window?.noticeOnlyText("此机型暂无此功能")
        
        switch sender.tag {
            
            //开关机
            case 666:
                
                break
            //hot
            case 777:
                
                break
            //cold
            case 888:
                
                break
            default:
                break
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
