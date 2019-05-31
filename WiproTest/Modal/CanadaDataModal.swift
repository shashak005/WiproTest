//
//  CanadaDataModal.swift
//  WiproTest
//
//  Created by Shashank on 30/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import UIKit

class CanadaDataModal: NSObject {
    
    var title:String = ""
    var descriptionValue:String = ""
    var imageUrl:String = ""


    
    init(data: [String: Any]) {
        
        if let datavalue = data[titlestr] as? String {
            title = datavalue
        }
        
        if let datavalue = data[descriptionstr] as? String {
            descriptionValue = datavalue
        }
        
        if let datavalue = data[imageHrefstr] as? String {
            imageUrl = datavalue
        }
    }


}
