//
//  WebService-Prefix.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

public enum WSRequestType : Int {
    
    case Login
    case SearchResult
  
    
}

public enum RESPONSE_STATUS : NSInteger {
    case INVALID
    case VALID
    case MESSAGE
}

public enum WSRequestForIG : Int {
    case APIGetUserPost
    case APIGetInstaUserInfo
}

struct WebServicePrefix {

    static let Server_URL = "http://www.kapugems.com/"
    static let WS_PATH = "mobWebService/REST/WebService/"
    
    static func GetWSUrl(serviceType :WSRequestType) -> String
    {
        var serviceURl: NSString?
        switch serviceType
        {
        case .Login:
            serviceURl = "authenticate"
            break
     
        case .SearchResult:
            serviceURl = "searchResult"
            break
           

        }
        return "\(Server_URL)\(WS_PATH)\(serviceURl!)" as String
    }
    
}
