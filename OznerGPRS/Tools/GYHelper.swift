//
//  GYHelper.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/22.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/22  上午10:50
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

struct MqttSendStruct {
    
    var key:String = ""
    var value:Any = ""
    var type:String = ""
    
}

class GYHelper: NSObject {
    
    
    class func mqttModelToJsonString(_ model:MqttSendStruct) -> String {
        
        let arr = [["key":model.key,"value":model.value,"type":model.type,"updateTime":Date().timeIntervalSince1970]]
        
        let data = try! JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        return String.init(data: data, encoding: String.Encoding.utf8)!
    }

}
