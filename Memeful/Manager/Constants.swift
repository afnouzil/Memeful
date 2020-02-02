//
//  Constants.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//


import Foundation

typealias ResponseHandler = (AnyObject?, NSError?) -> Void
typealias galleryHandler = ([Gallery]?, NSError?) -> Void

class Constants {
    enum ApiUrl:String{
        case galleryImage = "https://api.imgur.com/3/gallery/hot/viral/day/1?showViral=true&mature=true&album_previews=true"
    }
    
    enum ReuseableIdentifiers:String{
        case mostViralViewController = "MostViralViewController"
        case mostViralCollectionViewCell = "MostViralCollectionViewCell"
    }
}
