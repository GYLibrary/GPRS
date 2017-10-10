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
        
    @IBOutlet weak var isOnline: UILabel!
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

    func reloadUI(_ models: [String:ValuesModel]) {
        
        
        for (key,item) in models {

            switch key {
            case "Online":
                isOnline.text = String(describing: (item.value))  == "0" ? "设备掉线" : "设备在线"
                break
            case "PM25":
                pmLb.text = String(describing: (item.value))
                break
            case "VOCVAL":
                vocLb.text = String(describing: (item.value))
                break
            case "TIMEFIX1":
                lxtimeLb.text = secondstoString(String(describing: (item.value)))
                break
            case "WINDSPEED":
                speedLb.text = String(describing: (item.value))
                break
            case "CHILDLOCK":
                lockStateLb.text = String(describing: (item.value)) == "0" ? "关" : "开"
                break
            case "POWER":
                powerLb.text = String(describing: (item.value)) == "0" ? "关机" : "开机"
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
        
        let model  = MqttSendStruct(key: "WINDSPEED", value: speedArr[currenSpeed], type: "Integer")
        
//        let mqtt = MQTTHelper.default
//        mqtt.sendStringToDevice(GYHelper.mqttModelToJsonString(model), topic: "AirPurifier/f0fe6b49d02d")
//        mqtt.sendDataToDevice(GYHelper.mqttModelToData(model), topic: "AirPurifier/f0fe6b49d02d")
        OznerManager.default.currentDevice.sendDataToService(GYHelper.mqttModelToData(model))

    }
    
    //童锁
    @IBAction func speedSetAction(_ sender: UIButton) {
        
        var isPower = true
        if sender.titleLabel?.text == "关" {
            isPower = !isPower
            sender.setTitle("开", for: UIControlState.normal)
        } else {
            sender.setTitle("关", for: UIControlState.normal)
        }

        
        let model  = MqttSendStruct(key: "CHILDLOCK", value: isPower , type: "Boolean")
        
//        let mqtt = MQTTHelper.default
//        mqtt.sendStringToDevice(GYHelper.mqttModelToJsonString(model), topic: "AirPurifier/f0fe6b49d02d")
//        mqtt.sendDataToDevice(GYHelper.mqttModelToData(model), topic: "AirPurifier/f0fe6b49d02d")
        OznerManager.default.currentDevice.sendDataToService(GYHelper.mqttModelToData(model))
    }
    
    var power:Bool = true
    
    @IBAction func power(_ sender: UIButton) {
    
        var isPower = true
        
        if sender.titleLabel?.text == "关机" {
            isPower = !isPower
            sender.setTitle("开机", for: UIControlState.normal)
        } else {
            sender.setTitle("关机", for: UIControlState.normal)
        }
        
        let model  = MqttSendStruct(key: "POWER", value: isPower, type: "Boolean")
        
//        let mqtt = MQTTHelper.default
//        mqtt.sendStringToDevice(GYHelper.mqttModelToJsonString(model), topic: "AirPurifier/f0fe6b49d02d")
//        mqtt.sendDataToDevice(GYHelper.mqttModelToData(model), topic: "AirPurifier/f0fe6b49d02d")
        OznerManager.default.currentDevice.sendDataToService(GYHelper.mqttModelToData(model))
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
