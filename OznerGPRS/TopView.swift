//
//  TopView.swift
//  OznerGPRS
//
//  Created by ZGY on 2017/9/20.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/20  下午5:30
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class TopView: UIView {
    
    var block:(()->Void)?
    
    @IBAction func connectAvtion(_ sender: UIButton) {
        
//        sender.setTitle("连接中...", for: UIControlState.normal)
        block?()
        let str = devicetx.text! + "/" + mactx.text!
        let _ = OznerDevice.init(str)
        
        
    }
    @IBOutlet weak var devicetx: UITextField!

    @IBOutlet weak var mactx: UITextField!

    

}
