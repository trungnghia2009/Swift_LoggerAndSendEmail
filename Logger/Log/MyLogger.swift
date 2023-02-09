//
//  MyLogger.swift
//  Logger
//
//  Created by trungnghia on 07/02/2023.
//

import Foundation

struct MyLogger {
    
    private static let logFileManager = LogFileManager.shared
    
    enum LogLevel {
        case info
        case warning
        case error
        
        fileprivate var prefix: String {
            switch self {
            case .info:
                return "INFO"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
            }
        }
    }
    
    private struct Context {
        let file: String
        let function: String
        let line: Int
        
        private let currentDate = Date.getCurrentTime()
        
        var description: String {
            return "\(currentDate) \((file as NSString).lastPathComponent):\(line):\(function)"
        }
    }
    
    /// info log
    static func info(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        MyLogger.handleLog(level: .info, str: str, shouldLogContext: shouldLogContext, context: context)
    }
    
    /// warning log
    static func warning(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        MyLogger.handleLog(level: .warning, str: str, shouldLogContext: shouldLogContext, context: context)
    }
    
    /// error log
    static func error(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        MyLogger.handleLog(level: .error, str: str, shouldLogContext: shouldLogContext, context: context)
    }
    
    /// starting log
    static func start(file: String = #file, function: String = #function, line: Int = #line) {
        // Add break line
        MyLogger.logFileManager.writeLog("")
        
        let context = Context(file: file, function: function, line: line)
        let startingText = "-------------- starting \(Config.appName) \(Config.enviroment ?? .Debug) \(Config.version)(\(Config.build)) --------------\n"
        let deviceInfo = """
        ----- Device Info -----
        Model: \(DeviceInfo.modelType)
        System name: \(DeviceInfo.systemName)
        Version: \(DeviceInfo.version)
        Localized model: \(DeviceInfo.localizedModel)
        DeviceId: \(DeviceInfo.deviceID ?? "")\n
        """
        
        MyLogger.handleLog(level: .info, str: "\(startingText + deviceInfo)", shouldLogContext: true, context: context)
    }
    
    private static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]", str]
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString = "\(context.description) → " + fullString
        }
        
        MyLogger.logFileManager.writeLog(fullString)
        
        #if DEBUG || DEMO
        print(fullString)
        #endif
    }
}

private extension Date {
    static func getCurrentTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let formattedDate = format.string(from: Date())
        return formattedDate
    }
}

