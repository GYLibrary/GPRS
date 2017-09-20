//
//  MQTTHelper.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/18.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/18  上午9:51
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import MQTTKit

typealias recievedDataBlock = (Data,String) -> Void


class MQTTHelper: NSObject {
    
    var mqttClient:MQTTClient!
    
    static let `default`: MQTTHelper = MQTTHelper()

    var block:recievedDataBlock?
    
    override init() {
        
        super.init()
        
        mqttClient = MQTTClient(clientId: "1231zhu777777788")
        mqttClient.port=1884
        
        mqttClient.username="17621050877"//手机号
        var token = "12345678" + "@\(mqttClient.username!)" + "@\(mqttClient.clientID!)"
        
        token = Helper.base64EncodedString(from: Helper.md5(token))
        print("BASE64:\(token)")
        mqttClient.password=token//token
        mqttClient.keepAlive=60
        
        mqttClient.cleanSession=false
        
        
        //http://iot.ozner.net:1884 (内网地址请使用192.168.173.21:1884)
        mqttClient.connect(toHost: "iot.ozner.net") { (code) in
            
            switch code {
            case ConnectionAccepted:
                
                print("连接成功!")
//                self.mqttClient.subscribe("AirPurifier/f0fe6b49d02d", withQos: AtLeastOnce) { (dic) in
//                    print(dic)
//                    
//                }
            case ConnectionRefusedUnacceptableProtocolVersion:
                print("ConnectionRefusedUnacceptableProtocolVersion")
            case ConnectionRefusedIdentiferRejected:
                print("ConnectionRefusedIdentiferRejected")
            case ConnectionRefusedServerUnavailable:
                print("ConnectionRefusedServerUnavailable")
            case ConnectionRefusedBadUserNameOrPassword:
                print("ConnectionRefusedBadUserNameOrPassword")
            case ConnectionRefusedNotAuthorized:
                print("ConnectionRefusedNotAuthorized")
            default:
                print("连接失败")
            }
            
        }
        
        //校园空净 ID：类型名称/Mac

        mqttClient.messageHandler = {(mess) in
                    
            self.block!((mess?.payload)!,mess?.payloadString() ?? "")
            
            let arr = try! JSONSerialization.jsonObject(with: (mess?.payload)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
            for item in arr {
                
                print(item)
                
            }
            
//            let string = String.init(data: (mess?.payload)!, encoding: String.Encoding.utf8)
//            print(string)
//            
//            let dic = try! JSONSerialization.jsonObject(with: (mess?.payload)!, options: JSONSerialization.ReadingOptions.allowFragments)
//            print(dic)
            
        }
        
    }
    
    
    func subscribeAction(_ str:String) {
        print(str)
        
        mqttClient.subscribe(str, withQos: AtLeastOnce) { (result) in
            print(result ?? "")
            UserDefaults.standard.set(str, forKey: "OznerSubscribe")
            UserDefaults.standard.synchronize()
            
        }
    }
    
    func unsubscribAction(_ str:String) {
        
        mqttClient.unsubscribe(str) {
            
            print("已取消订阅")
            UserDefaults.standard.setValue(nil, forKey: "OznerSubscribe")
            UserDefaults.standard.synchronize()

        }
        
    }

    func sendDataToDevice(_ data:Data,topic:String) {
        
        mqttClient.publishData(data, toTopic: topic, withQos: AtMostOnce, retain: true) { (code) in
            print(code)
        }
        
    }
    
    func sendStringToDevice(_ sendStr:String,topic:String) {
        
        mqttClient.publishString(sendStr, toTopic: topic, withQos: AtMostOnce, retain: true) { (code) in
            print(code)
        }
        
    }
    


    
    
}
