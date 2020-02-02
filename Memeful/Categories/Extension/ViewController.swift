//
//  ViewController.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 2/1/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import UIKit
import Toast_Swift
extension UIViewController{
    func toast(title:String,duration:Double,color:UIColor){
        var style = ToastStyle()
        style.messageColor = color
        self.view.makeToast(title, duration: duration, position: .center, style: style)
        
    }

}
