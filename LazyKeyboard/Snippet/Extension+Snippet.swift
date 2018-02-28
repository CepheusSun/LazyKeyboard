//
//  Extension+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

extension FileManager {
    
    static var documentDirectory: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .last!
    }
}

extension String {
    
    var fileName: String {
        return "your_app_unique_prefix_"
            + self
            + ".json"
    }
    
    var fileURL: URL {
        return FileManager
            .documentDirectory
            .appendingPathComponent(fileName)
    }
}

extension URL {
    
    var fileContent: Data? {
        return FileManager
            .default
            .contents(atPath: path)
    }
}
