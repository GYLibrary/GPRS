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

    var topView:TopView!
    var mqtt:MQTTHelper!
    var dataArr:[String:ValuesModel] = [:]
    var cellCount:Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataArr.count)

        mqttInfo()
        
//        tableView.backgroundColor = UIColor.init(red: 159/255.0, green: 225/255.0, blue: 250/255.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        
        topView = UINib.init(nibName: "TopView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! TopView
        
        topView.block = { () in
            
            self.cellCount = 1
            self.tableView.tableHeaderView = nil
            
        }
        
        tableView.tableHeaderView = topView
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "AirPuterfierCell", bundle: nil), forCellReuseIdentifier: "AirPuterfierCellID")
        tableView.register(UINib.init(nibName: "WaterPurifiCell", bundle: nil), forCellReuseIdentifier: "WaterPurifiCellID")
    }
    
    private func mqttInfo() {
        
        
        navigationItem.leftBarButtonItem = nil
        mqtt = MQTTHelper.default
        
        mqtt.block = { (data,ploadStr) -> Void in
            
            print(ploadStr)
            
            let dic = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Dictionary<String, Any>]
            
            for item:Dictionary in dic {
                
                print(item["key"]!)
                        
                let model = ValuesModel()
                model.key = item["key"] as! String
                model.updateTime = (item["updateTime"] as? Int ?? 0)!
                model.value = item["value"] as AnyObject
                self.dataArr[model.key] = model
                
            }
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
            }

        }
    
        sleep(2)

        GYNetWorking.default.requestJson(GYRouter.getQuery(parameters: ["deviceType":"AirPurifier","deviceId":"f0fe6b49d02d"]), sucess: { (data) in
            
            //            print(data["values"])
            let jsonArr = data["values"] as! [[String:Any]]
            
            for item in jsonArr {
                
                let model = ValuesModel()
                model.key = (item["key"] as? String)!
                model.updateTime = (item["updateTime"] as? Int ?? 0)!
                model.value = item["value"] ?? ""
                if model.key == "Online" {
                    print("当前连接状态:\(String(describing: model.value))")
                }
                self.dataArr[model.key] = model
                
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }

    @IBAction func scanCodeAction(_ sender: UIBarButtonItem) {

        let vc = QQScanViewController();
        vc.blcok = { (str) in
            
            let device = OznerDevice.init(str!)
            
            
            self.cellCount = 1
//            MQTTHelper.default.subscribeAction(str!, block: { (state) in
//                print(state)
//            })
        }
        var style = LBXScanViewStyle()
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let str = UserDefaults.standard.value(forKey: "OznerSubscribe"){
            
            self.tableView.tableHeaderView = nil
            cellCount = 1
            mqtt.subscribeAction(str as! String, block: { (state) in
                print(state)
            })
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WaterPurifiCellID") as! WaterPurifiCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirPuterfierCellID") as! AirPuterfierCell
//        
        cell.selectionStyle = .none
        //159  225 250
//        cell.backgroundColor = UIColor.init(red: 159/255.0, green: 225/255.0, blue: 250/255.0, alpha: 1.0)
        cell.reloadUI(dataArr)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            cellCount = 0
            mqtt.unsubscribAction("AirPurifier/f0fe6b49d02d")
            tableView.tableHeaderView = topView

        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height - 70
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchPush" {
            
            let vc = segue.destination as! HistoryVc
            var titleArr = ["VOCVAL","PM25","POWER","HUMIDITY","TEMPERATURE","WINDSPEED"]
            
            vc.title = titleArr[Int(arc4random()%5)]
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

