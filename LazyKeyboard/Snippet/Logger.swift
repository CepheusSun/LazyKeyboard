//
//  Logger.swift
//  Snippet
//
//  Created by sunny on 2017/6/1.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// log 类型的枚举
public enum LogEvent: String {
    case error = "[‼️]" // error
    case info = "[ℹ️]" // info
    case debug = "[💬]" // debug
    case verbose = "[🔬]" // verbose
    case warning = "[⚠️]" // warning
    case sever = "[🔥]" // sever
}

public final class Logger {
    
    private static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func log(message: String,
                   event: LogEvent,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {
        
        #if DEBUG
        
        print("\(Date().toString()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        
        #endif
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
}

internal extension Date {
    func toString() -> String {
        return ""
    }
}
