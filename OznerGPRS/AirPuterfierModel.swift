//
//  AirPuterfierModel.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/20.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/20  上午10:18
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

struct AirPuterfierStruct {
    
    var POWER:Bool = false
    var WINDSPEED:Int = 0
    var CHILDLOCK:Bool = false
    var TIMEFIX1:Int = 0
    var VOCVAL:Int = 0
    
    func description() -> String {
        
        return ""
    }
    
}

class AirPuterfierModel: NSObject {
    
    var POWER:Bool = false
    var WINDSPEED:Int = 0
    var CHILDLOCK:Bool = false
    var TIMEFIX1:Int = 0
    var VOCVAL:Int = 0

}
