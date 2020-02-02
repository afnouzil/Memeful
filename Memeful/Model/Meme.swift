//
//  Meme.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import Foundation
import ObjectMapper

class Gallery: NSObject, Mappable {
    
    var id: String?
    var title: String?
    var points: Int?
    var image: [Images]?
    var views: Int?
    var tags: [Tags]?

    
    
      required init?(map: Map) {
       }
       override init() {
           super.init()
       }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        points <- map["points"]
        image <- map["images"]
        views <- map["views"]
        tags <- map["tags"]



    }
}
class Images: NSObject, Mappable {
        var type: String?
        var link: String?
        var desc: String?

      required init?(map: Map) {
       }
       override init() {
           super.init()
       }

    func mapping(map: Map) {
        type <- map["type"]
        link <- map["link"]
        desc <- map["description"]

    }
}
class Tags: NSObject, Mappable {
        var displayName: String?

      required init?(map: Map) {
       }
       override init() {
           super.init()
       }

    func mapping(map: Map) {
        displayName <- map["display_name"]

    }
}
