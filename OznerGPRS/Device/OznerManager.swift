//
//  OznerManager.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/23.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/23  下午2:02
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class OznerManager: NSObject {

    static let `default`: OznerManager = OznerManager()
    
    // 切换水杯时先取消当前设备的订阅
    var currentDevice:OznerDevice! {
        
        didSet {
            
            if currentDevice != oldValue {
                
                if let _ = oldValue {
                    oldValue.unsubscribAction()

                }
                
                
            }
            
        }
        
    }
    
    
}
