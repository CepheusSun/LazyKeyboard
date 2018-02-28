//
//  Encrypt.swift
//  Snippet
//
//  Created by sunny on 2017/9/20.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation


// base 64
extension String {
    
    var base64: String {
        let utf8str:Data? = self.data(using: String.Encoding.utf8)
        guard let utf8Data = utf8str else{
            return ""
        }
        
        let base64Encoded:String = utf8Data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return base64Encoded

    }

}
