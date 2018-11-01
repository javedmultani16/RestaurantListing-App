//
//  HttpRequestManager.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class HttpRequestManager {
    
    static let sharedInstance = HttpRequestManager()
    
    var responseObjectDic = Dictionary<String, AnyObject>()
    var URLString : String!
    var Message : String!
    
    private static var Manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            WebServicePrefix.Server_URL: .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    // METHODS
    init() {}
    
    //MARK:- POST Request
    
    func postParameterRequest(endpointurl:String, reqParameters:NSDictionary ,responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool) -> Void)
    {
        DLog( "URL : \(endpointurl) \nParam :\( reqParameters) ")
        ShowNetworkIndicator(xx: true)
        
        
        Alamofire.request(endpointurl, method: .post, parameters: reqParameters  as? [String: Any])
//            .responseString(queue: DispatchQueue.main, encoding: String.Encoding.ascii
//                , completionHandler: { (reponse) in
//                    print(reponse)
//            })
            .responseJSON { response in
                ShowNetworkIndicator(xx: false)
                
                DLog(response.request)  // original URL request
                DLog(response.response) // URL response
                DLog(response.data)     // server data
                DLog(response.result)   // result of response serialization
                
                if let _ = response.result.error
                {
                    responseData(nil, response.result.error as NSError?, SOMETHING_WRONG,false)
                }
                else
                {
                    switch response.result {
                        
                    case .success(_):
                        
                        self.responseObjectDic = response.result.value as! Dictionary<String, AnyObject>
                        responseData(self.responseObjectDic, nil, "Success", true)
                        
//                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
//                            print("Invalid tag information received from the service")
//                            responseData(nil, nil, "Failed to parse data", false)
//                            return
//                        }
                        
                      
                        
                    case .failure(let error):
                        print(error)
                        responseData(nil, error as NSError?, "Failed", false)
                    }
                }
        }
    }
    
    func postJSONRequest(endpointurl:String, jsonParameters:[String: Any], responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool) -> Void)
    {
        DLog( "URL : \(endpointurl) \nParam :\( jsonParameters) ")
        var dic = jsonParameters
        dic["DS"] = "KG"
        
        ShowNetworkIndicator(xx: true)
        Alamofire.request(endpointurl, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                ShowNetworkIndicator(xx: false)
                
                DLog(response.request)  // original URL request
                DLog(response.response) // URL response
                DLog(response.data)     // server data
                DLog(response.result)   // result of response serialization
                
                if let _ = response.result.error
                {
                    responseData(nil, response.result.error as NSError?, SOMETHING_WRONG,false)
                }
                else
                {
                    switch response.result {
                        
                    case .success(_):
                        
                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
                            DLog("Invalid tag information received from the service")
                            responseData(nil, nil, "Failed to parse data", false)
                            return
                        }
                        
                        //added new lines
                          self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                        responseData(self.responseObjectDic, nil, "Success", true)
                        //Uncomment later
                        /*self.Message = responseJSON["message"] as! String
                        var st:Bool = false
                        switch (responseJSON["success"] as! NSInteger) {
                            
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = true
                            break
                            
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = false
                            break
                            
                        default :
                            break
                            
                        }
                        responseData(self.responseObjectDic, nil, self.Message, st)
                        */
                    case .failure(let error):
                        DLog("\(error)")
                        responseData(nil, error as NSError?, "Failed", false)
                    }
                }
        }
    }
    
    //MARK:- GET Request1
    func getRequestWithoutParams(endpointurl:String,responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool)  -> Void)
    {
        DLog( "URL : \(endpointurl)")
        ShowNetworkIndicator(xx: true)
        HttpRequestManager.Manager.request(endpointurl, method : .get)
            .responseJSON { response in
                ShowNetworkIndicator(xx: false)
                
                DLog(response.request)  // original URL request
                DLog(response.response) // URL response
                DLog(response.data)     // server data
                DLog(response.result)   // result of response serialization
                if let _ = response.result.error
                {
                    responseData(nil, response.result.error as NSError?, SOMETHING_WRONG,false)
                }
                else
                {
                    switch response.result {
                        
                    case .success(_):
                        
                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
                            print("Invalid tag information received from the service")
                            responseData(nil, nil, "Failed to parse data", false)
                            return
                        }
                        
                        self.Message = responseJSON["message"] as! String
                        var st:Bool = false
                        switch (responseJSON["success"] as! NSInteger) {
                            
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = true
                            break
                            
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = false
                            break
                            
                        default :
                            break
                            
                        }
                        responseData(self.responseObjectDic, nil, self.Message, st)
                        
                    case .failure(let error):
                        print(error)
                        responseData(nil, error as NSError?, "Failed", false)
                    }
                }
        }
    }
    
    //MARK:- GET Request
    func getRequest(endpointurl:String,parameters:NSDictionary,responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool) -> Void)
    {
        DLog( "URL : \(endpointurl) \nParam :\( parameters) ")
        ShowNetworkIndicator(xx: true)
        Alamofire.request(endpointurl , method: .get, parameters: parameters as? [String : AnyObject])
            .responseJSON { response in
                ShowNetworkIndicator(xx: false)
                
                DLog(response.request)  // original URL request
                DLog(response.response) // URL response
                DLog(response.data)     // server data
                DLog(response.result)   // result of response serialization
                
                if let _ = response.result.error
                {
                    responseData(nil, response.result.error as NSError?, SOMETHING_WRONG,false)
                }
                else
                {
                    switch response.result {
                        
                    case .success(_):
                        
                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
                            print("Invalid tag information received from the service")
                            responseData(nil, nil, "Failed to parse data", false)
                            return
                        }
                        
                        self.Message = responseJSON["message"] as! String
                        var st:Bool = false
                        switch (responseJSON["success"] as! NSInteger) {
                            
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = true
                            break
                            
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = false
                            break
                            
                        default :
                            break
                            
                        }
                        responseData(self.responseObjectDic, nil, self.Message, st)
                        
                    case .failure(let error):
                        print(error)
                        responseData(nil, error as NSError?, "Failed", false)
                    }
                }
        }
    }
    
    
    //MARK:- PUT Request
    func putRequest(endpointurl:String, jsonParameters:[String : Any],responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool) -> Void)
    {
        ShowNetworkIndicator(xx: true)
        Alamofire.request(endpointurl, method: .put, parameters: jsonParameters)
            .responseJSON { response in
                ShowNetworkIndicator(xx: false)
                
                DLog(response.request)  // original URL request
                DLog(response.response) // URL response
                DLog(response.data)     // server data
                DLog(response.result)   // result of response serialization
                
                if let _ = response.result.error
                {
                    responseData(nil, response.result.error as NSError?, SOMETHING_WRONG,false)
                }
                else
                {
                    switch response.result {
                        
                    case .success(_):
                        
                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
                            print("Invalid tag information received from the service")
                            responseData(nil, nil, "Failed to parse data", false)
                            return
                        }
                        
                        self.Message = responseJSON["message"] as! String
                        var st:Bool = false
                        switch (responseJSON["success"] as! NSInteger) {
                            
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = true
                            break
                            
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = false
                            break
                            
                        default :
                            break
                            
                        }
                        responseData(self.responseObjectDic, nil, self.Message, st)
                        
                    case .failure(let error):
                        print(error)
                        responseData(nil, error as NSError?, "Failed", false)
                    }
                }
        }
    }
    
    //MARK: - MULTIPART REQUEST
    //func uploadImages(endpointurl:String, parameters:NSDictionary, filePath:URL, fileName:String ,responseData:@escaping ( _ error: NSError?, _ message: String?, _ responseDict: Any?,_ rStaus:Bool) -> Void)  {
        
    func uploadImages(endpointurl:String, parameters:NSDictionary, image : UIImage?, fileKey:String ,responseData:@escaping (_ data:Dictionary<String, AnyObject>?,_ error:NSError?,_ message:String, _ rStaus:Bool) -> Void)  {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                multipartFormData.append(UIImageJPEGRepresentation(image!, 1)!, withName: fileKey, fileName: "abc.jpg", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                var valueStr:String = ""
                if let intVlaue:Int   = value as? Int{
                    valueStr = String(format:"%d",intVlaue)
                }else{
                    valueStr = value as! String
                }
                multipartFormData.append(valueStr.data(using: String.Encoding.utf8)!, withName: key as! String)
            }
        }, to:endpointurl)
        { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                
                upload.responseJSON { response in
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.request!)  // original URL request
                        
                        guard let responseJSON:NSDictionary = response.result.value as? NSDictionary else {
                            print("Invalid tag information received from the service")
                            responseData(nil, nil, "Failed to parse data", false)
                            return
                        }
                        
                        self.Message = responseJSON["message"] as! String
                        var st:Bool = false
                        switch (responseJSON["success"] as! NSInteger) {
                            
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = true
                            break
                            
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.responseObjectDic = (responseJSON as AnyObject?) as! Dictionary<String, AnyObject>
                            st = false
                            break
                            
                        default :
                            break
                            
                        }
                        
                        responseData(self.responseObjectDic, nil, self.Message, st)
                    }
                }
                
            case .failure(let error):
                responseData(nil, error as NSError?, "Failed", false)
                break
            }
        }

    }
    
}
