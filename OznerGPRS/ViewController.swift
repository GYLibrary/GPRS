//
//  ViewController.swift
//  OznerGPRS
//
//  Created by macpro on 2017/9/18.
//  Copyright © 2017年 macpro. All rights reserved.
//

import UIKit
import swiftScan


class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var mqtt:MQTTHelper!
    var dataArr:[ValuesModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mqttInfo()
        
        mqtt = MQTTHelper.default
        
        mqtt.block = { (data,ploadStr) -> Void in
            
            print(ploadStr)
            
            let dic = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Dictionary<String, Any>]
            
            for item:Dictionary in dic {
                
                print(item["key"]!)
                
            }
        }
        sleep(2)
        
        GYNetWorking.default.requestJson(GYRouter.getQuery(parameters: ["deviceType":"AirPurifier","deviceId":"f0fe6b49d02d"]), sucess: { (data) in
            
//            print(data["values"])
            let jsonArr = data["values"] as! [[String:Any]]
            
            for item in jsonArr {
                
                let model = ValuesModel()
                model.key = item["key"] as? String
                model.updateTime = item["updateTime"] as? String
                model.value = item["value"] as? String
                self.dataArr.append(model)
                
            }
            
            print(self.dataArr)
            self.tableView.reloadData()
            
            
        }) { (error) in
            print(error)
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib.init(nibName: "AirPuterfierCell", bundle: nil), forCellReuseIdentifier: "AirPuterfierCellID")
    }
    
    private func mqttInfo() {
        
       
    }

    @IBAction func scanCodeAction(_ sender: UIBarButtonItem) {

        let vc = QQScanViewController();
        vc.blcok = { (str) in

            MQTTHelper.default.subscribeAction(str!)
        }
        var style = LBXScanViewStyle()
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let str = UserDefaults.standard.value(forKey: "OznerSubscribe"){
            
            mqtt.subscribeAction(str as! String)
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirPuterfierCellID") as! AirPuterfierCell
        
        cell.selectionStyle = .none
        cell.reloadUI(dataArr)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

