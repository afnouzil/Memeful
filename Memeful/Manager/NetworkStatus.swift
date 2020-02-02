//
//  NetworkStatus.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import Foundation
import Alamofire
class NetworkStatus {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    struct  Network{
        static var offline = "The Internet connection appears to be offline."
        
    }
}

