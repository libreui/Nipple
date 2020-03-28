//
//  OCRBasicModel.swift
//  CutOCR
//
//  Created by Libre on 2020/3/28.
//  Copyright © 2020 Libre. All rights reserved.
//

import HandyJSON

class OCRBasicModel: HandyJSON {
    
    var log_id : Int64?
    var words_result_num : Int32?
    var words_result : [BasicItem]?
    
    required init(){}
    
    
}

class BasicItem:HandyJSON {
    var words:String?
    required init(){}
}
