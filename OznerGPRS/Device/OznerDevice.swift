//
//  OznerDevice.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/22.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/22  下午3:09
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

enum OznerDeviceState {
    
    case Connected
    case Connecting
    case Disconnected
    
}

protocol OznerDeviceProtocol {
    
    func deviceState(_ state:OznerDeviceState)
    
}

class OznerDevice: NSObject {
    
    var isConnected:Bool = false
    
    var currentState:OznerDeviceState = .Connecting
    
    var devicetopic:String = ""
    
    init(_ topic:String) {
        super.init()
        
        devicetopic = topic
        MQTTHelper.default.subscribeAction(topic) { [weak self] (state) in
            self?.currentState = state
        }
        
    }

}
