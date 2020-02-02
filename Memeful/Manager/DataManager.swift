
//
//  DataManager.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import Foundation
import ObjectMapper

class DataManager{
    static let shared : DataManager = DataManager()
    func getGalleryImages(compHandler: @escaping galleryHandler)
    {
        let path = Constants.ApiUrl.galleryImage.rawValue
        ApiManager.shared.getResponse(path) { (res, err) in
            if let response = res as? [String:Any]
            {
                if let data = response["data"] as? [[String:Any]]{
                    let post = Mapper<Gallery>().mapArray(JSONObject: data)
                    compHandler(post,nil)

                }else{
                    compHandler(nil,err)
                }

            }
            
        }
    }

}
