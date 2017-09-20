//
//  AirPuterfierCell.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/20.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/20  上午9:57
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class AirPuterfierCell: UITableViewCell {
        
    @IBOutlet weak var pmLb: UILabel!
    @IBOutlet weak var lxtimeLb: UILabel!
    @IBOutlet weak var powerLb: UILabel!
    @IBOutlet weak var speedLb: UILabel!
    @IBOutlet weak var lockStateLb: UILabel!
    @IBOutlet weak var vocLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reloadUI(_ models: [ValuesModel]) {
        
        
        for item in models {
            print(item.key!)
            switch item.key! {
            case "PM25":
                pmLb.text = item.value
                break
            case "VOCVAL":
                vocLb.text = item.value
                break
            case "TIMEFIX1":
                lxtimeLb.text = item.value
                break
            case "WINDSPEED":
                speedLb.text = item.value
                break
            case "CHILDLOCK":
                lockStateLb.text = item.value
                break
            case "POWER":
                powerLb.text = item.value
                break
                
            default:
                break
            }
            
        }
        
        
    }
    
    
    @IBAction func power(_ sender: Any) {
        
        
        let arr = [["key":"POWER","type":"Boolean","value":1,"updateTime":Date().timeIntervalSince1970]]
        let data = try! JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
        let str = String.init(data: data, encoding: String.Encoding.utf8)
        
        let mqtt = MQTTHelper.default
//        mqtt.sendDataToDevice(data, topic: "AirPurifier/f0fe6b49d02d")
        mqtt.sendStringToDevice(str!, topic: "AirPurifier/f0fe6b49d02d")
        
            
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
