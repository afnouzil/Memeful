//
//  ApiManager.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import Foundation
import Alamofire

//Client ID : e658f89705f4f3b

class ApiManager : NSObject  {
    
    static let shared : ApiManager = ApiManager()
    var alamofireManager : Alamofire.SessionManager!
    var clientID = "e658f89705f4f3b"
    
    override init() {
        super.init()
        initAlamofire()
    }
    
    func initAlamofire() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10000
        config.timeoutIntervalForResource = 10000
        alamofireManager = Alamofire.SessionManager(configuration: config)
    }
    // GET API
    
    func getResponse(_ path:String, params:[String:Any] = [:],responseHandler:@escaping ResponseHandler)
    {
        var filePath = ""
        filePath = path
        let parameters:[String:String] = ["Authorization":"Client-ID e658f89705f4f3b"]
        
        print(filePath)
        alamofireManager.request(filePath, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: parameters).responseJSON() {
            response in
            if (response.result.isSuccess)
            {
                if response.response!.statusCode == 200
                {
                    responseHandler(response.result.value as AnyObject,nil)
                }
                else
                {
                    
                    var message:String! = nil
                    if (response.result.value is [String:AnyObject] && ((response.result.value! as! [String:Any])["message"]) != nil)
                    {
                        message = ((response.result.value! as! [String:Any])["message"]) as? String
                    }
                    let statusCode = response.response!.statusCode
                    self.parseErrorResponse(message, statusCode: statusCode, responseHandler: responseHandler)
                }
            }
            else
            {
                if response.response != nil
                {
                    self.parseErrorResponse("Something went wrong! Please try again later.", statusCode: response.response!.statusCode, responseHandler: responseHandler)
                }
                else
                {
                    if response.result.isFailure == true && response.result.error?._code == -999 {
                        let error = NSError(domain: "", code: -999, userInfo: nil)
                        responseHandler(nil, error)
                        return
                    }
                    let error = NSError(domain: "Something went wrong! Please try again later.", code: 0, userInfo: nil)
                    responseHandler(nil, error)
                    return
                }
            }
        }
    }
    
    func parseErrorResponse(_ msg:String!, statusCode:Int, responseHandler:ResponseHandler) {
        var message:String! = msg
        switch statusCode {
        case 204:
            message = message ?? "No Results found"
            break
        case 500...599:
            message = message ?? "Oops! Our server is not responding"
            break
        case 404:
            message = message ??  "Nothing found"
            break
        case 400:
            message = message ??  "Bad Request"
            break
        case 401:
            //            self.logoutUser()
            //            self.generateToken()
            message = message ??  "You are not authorized for this request"
            break
        case 412:
            message = message ??  "You input is invalid"
            break
        case 406:
            message =  message ??  "Token expired"
        default:
            message = message ??  "Please try again"
        }
        let error = NSError(domain: (message)!, code: statusCode, userInfo: nil)
        responseHandler(nil,error)
    }
}
