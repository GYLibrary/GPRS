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

            switch item.key {
            case "PM25":
                pmLb.text = String(describing: (item.value!))
                break
            case "VOCVAL":
                vocLb.text = String(describing: (item.value!))
                break
            case "TIMEFIX1":
                lxtimeLb.text = secondstoString(String(describing: (item.value!)))
                break
            case "WINDSPEED":
                speedLb.text = String(describing: (item.value!))
                break
            case "CHILDLOCK":
                lockStateLb.text = String(describing: (item.value!)) == "0" ? "关" : "开"
                break
            case "POWER":
                powerLb.text = String(describing: (item.value!)) == "0" ? "关机" : "开机"
                break
                
            default:
                break
            }
            
        }
        
        
    }
    
    private func secondstoString(_ seconds:String) -> String{
        
        let data = Date.init(timeIntervalSince1970: TimeInterval(seconds)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        return formatter.string(from: data)
        
    }
    
    var currenSpeed = 0
    @IBAction func speed2Action(_ sender: UIButton) {
        
        var speedArr = [0,4,5]
        
        currenSpeed += 1
        
        if currenSpeed >= 3 {
            currenSpeed = 0
        }
        
        
//        let arr = [["key":"WINDSPEED","value":speedArr[currenSpeed],"type":"Integer","updateTime":Date().timeIntervalSince1970]]
//        
//        let data = try! JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
//        
//        let str = String.init(data: data, encoding: String.Encoding.utf8)
//        print(str!)
        
        let model  = MqttSendStruct(key: "WINDSPEED", value: speedArr[currenSpeed] as AnyObject, type: "Integer")
        
        let mqtt = MQTTHelper.default
        mqtt.sendStringToDevice(GYHelper.mqttModelToJsonString(model), topic: "AirPurifier/f0fe6b49d02d")

    }
    
    //童锁
    @IBAction func speedSetAction(_ sender: UIButton) {
        
        let model  = MqttSendStruct(key: "WINDSPEED", value: true as AnyObject, type: "Boolean")
        
        let mqtt = MQTTHelper.default
        mqtt.sendStringToDevice(GYHelper.mqttModelToJsonString(model), topic: "AirPurifier/f0fe6b49d02d")
        
//        let arr = [["key":"CHILDLOCK","value":isPower,"type":"Boolean","updateTime":Date().timeIntervalSince1970]]

//        let data = try! JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
//        
//        let str = String.init(data: data, encoding: String.Encoding.utf8)
//        print(str!)
//        let mqtt = MQTTHelper.default
//        mqtt.sendStringToDevice(str!, topic: "AirPurifier/f0fe6b49d02d")
        
    }
    
    var power:Bool = true
    
    @IBAction func power(_ sender: UIButton) {
    
//        let arr = [["key":"POWER","value":isPower,"type":"Boolean","updateTime":Date().timeIntervalSince1970]]
//        let data = try! JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//        let str = String.init(data: data, encoding: String.Encoding.utf8)
//        print(str!)
//        let mqtt = MQTTHelper.default
//        mqtt.sendStringToDevice(str!, topic: "AirPurifier/f0fe6b49d02d")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
