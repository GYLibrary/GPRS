//
//  Router.swift
//  GYHelpToolsSwift
//
//  Created by ZGY on 2017/4/14.
//  Copyright © 2017年 Giant. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/14  17:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import  Alamofire

/// URL 以及参数封装
///
/// - login: 登录
/// - register: 注册
enum GYRouter: URLRequestConvertible {
    
    
    public func asURLRequest() throws -> URLRequest {
        return self.urlRequest
    }

    static var token:String?
    
    case login(parameters:[String: String])
    case register(parameters:[String: String])
    case getPhoneCode(parameters:[String: String])
    case submitUserInfoDetaile(parameters:[String: String])
    case submitApplication(parameters:[String: String])
    case getUserInfo(parameters:[String: String])
    case getUserApplyState(parameters:[String: String])
    case compactInfo(parameters:[String:String])
    case getMyInviter(parameters:[String:String])
    case getInviterInfo(parameters:[String:String])
    case getUserApplyHistory(parameters:[String:String])
    case getUserApplyStateByID(parameters:[String:String])
    case isCanApply(parameters:[String:String])
    
    
    case getQuery(parameters:[String:String])
    case setterDevice(parameters:NSDictionary)
    case searchDevice(parameters:NSDictionary)
    /// 请求方式
    var method: Alamofire.HTTPMethod {
        
        switch self {
            
        case .login:
            return .post
        case .register:
            return .post
        case .getPhoneCode:
            return .get
        case .submitUserInfoDetaile:
            return .post
        case .submitApplication:
            return .post
        case .getUserInfo:
            return .post
        case .getUserApplyState:
            return .post
        case .compactInfo,.isCanApply,.getMyInviter,.getInviterInfo,.getUserApplyHistory,.getUserApplyStateByID:
            return .post
        case .getQuery,.searchDevice:
            return .get
        case .setterDevice:
            return .post
        
        }
        
    }
    
    
    /// 路径
    var path: String {
        
        switch self {
        case .login:
            return GYServiceApi.login()
        case .register:
            return GYServiceApi.register()
        case .getPhoneCode:
            return GYServiceApi.getPhoneCode()
        case .submitUserInfoDetaile:
            return GYServiceApi.submitUserInfoDetaile()
        case .submitApplication:
            return GYServiceApi.SubmitApplication()
        case .getUserInfo:
            return GYServiceApi.GetUserInfo()
        case .getUserApplyState:
            return GYServiceApi.GetUserApplyState()
        case .compactInfo:
            return GYServiceApi.CompactInfo()
        case .getMyInviter:
            return GYServiceApi.GetMyInviter()
        case .getInviterInfo:
            return GYServiceApi.GetInviterInfo()
        case .getUserApplyHistory:
            return GYServiceApi.GetUserApplyHistory()
        case .getUserApplyStateByID:
            return GYServiceApi.GetUserApplyStateByID()
        case .isCanApply:
            return GYServiceApi.IsCanApply()
        case .getQuery:
            return GYServiceApi.getQuery()
        case .setterDevice:
            return GYServiceApi.setterDevice()
        case .searchDevice:
            return GYServiceApi.searchDevice()
        }
        
    }
    
    var urlRequest: URLRequest {
        
        let url = URL(string: path)!
        
        var mutableURLRequest = URLRequest(url: url)
        mutableURLRequest.httpMethod = method.rawValue
        
        /// 根据需求设置
//        GYRouter.token = UserAccount.loadAccount()?.acctoken
        if let token = GYRouter.token {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "usertoken")
        }
        
        mutableURLRequest.setValue("com.ozner", forHTTPHeaderField: "clientid")
        mutableURLRequest.setValue("1.0", forHTTPHeaderField: "appversion")
        mutableURLRequest.timeoutInterval = 10
        switch self {
            
        case .login(var parm),.register(var parm),.getPhoneCode(parameters: var parm),.submitUserInfoDetaile(parameters: var parm),.submitApplication(parameters: var parm),.getUserInfo(parameters: var parm),.getUserApplyState(parameters: var parm),.compactInfo(parameters: var parm),.getMyInviter(var parm),.getInviterInfo(parameters: var parm),.getUserApplyHistory(parameters: var parm),.getUserApplyStateByID(parameters: var parm),.isCanApply(parameters: var parm),.getQuery(parameters: var parm):
            do {
                
                return try Alamofire.URLEncoding().encode(mutableURLRequest, with: parm)
            } catch  {
                
            }
        case .setterDevice(parameters: var parm),.searchDevice(parameters: var parm):
            
            do {
                
                return try Alamofire.URLEncoding().encode(mutableURLRequest, with: parm as! Parameters)
            } catch  {
                
            }
        }
        
        return mutableURLRequest
        
    }
    
}
