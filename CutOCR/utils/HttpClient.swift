//
//  HttpClient.swift
//  CutOCR
//
//  Created by Libre on 2020/3/27.
//  Copyright © 2020 Libre. All rights reserved.
//

import Alamofire

class HttpClient {
    
    typealias onSuccess = (_ response:String) -> Void
    typealias onSuccessJson = (_ response:Any) -> Void
    
    func getAccessToken(block: @escaping onSuccess) {
        // https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=Va5yQRHlA4Fq5eR3LT0vuXV4&client_secret=0rDSjzQ20XUj5itV6WRtznPQSzr5pVw2&
        let postData = [
            "grant_type" : "client_credentials",
            "client_id" : BAIDU_APP_KEY,
            "client_secret" : BAIDU_SECRET_KEY
        ]
        
        AF.request("https://aip.baidubce.com/oauth/2.0/token",
                   method: .post,
                   parameters: postData).responseString { response in
                    block(response.value ?? "[]")
        }
    }
    
    static func getOCR(imgBase64:String, block: @escaping onSuccess) {
        // https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic
        let postData = [
            "image" : imgBase64
        ]
        let headers : HTTPHeaders = [
            .contentType("application/x-www-form-urlencoded"),
            .accept("application/json;charset=UTF-8")
        ]
        
        AF.request(
            "https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=" + Cache.TOKEN,
            method: .post,
            parameters: postData,
            headers: headers
        ).responseString { response in
            let str = String(data:response.data!, encoding: String.Encoding.utf8)
            block(str ?? "")
        }
        
    }
}
