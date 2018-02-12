//
//  Log.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import SwiftyBeaver

class Log: NSObject {
    
    let log = SwiftyBeaver.self
    
    static var sharedInstance = Log()
    
    override init() {
        super.init()
        
        let console = ConsoleDestination()
        console.asynchronously = true
        self.log.addDestination(console)
    }
    
    func error(_ error: Any,_ fileName: String,_ function: String,_ line: Int) {
        return self.log.error(error, fileName, function, line: line)
    }
    
    func info(_ info: Any,_ fileName: String,_ function: String,_ line: Int) {
        return self.log.info(info, fileName, function, line: line)
    }
    
    func verbose(_ verbose: Any,_ fileName: String,_ function: String,_ line: Int) {
        return self.log.verbose(verbose)
    }
    
    func debug(_ debug: Any,_ fileName: String,_ function: String,_ line: Int) {
        return self.log.debug(debug)
    }
    
    func warning(_ warning: Any,_ fileName: String,_ function: String,_ line: Int) {
        return self.log.warning(warning)
    }
}

public class Logger: NSObject {

    class func initLogger() {
        _ = Log.sharedInstance
    }
    
    public class func error(_ error: Any,
                            toSlack: Bool = true,
                            fileName: String = #file,
                            function: String = #function,
                            line: Int = #line) {
        
        Log.sharedInstance.error(error, fileName, function, line)
    }
    
    public class func info(_ info: Any,
                           _ file: String = #file,
                           _ function: String = #function,
                           _ line: Int = #line) {
        
        Log.sharedInstance.info(info, file, function, line)
    }
    
    public class func verbose(_ verbose: Any,
                              _ file: String = #file,
                              _ function: String = #function,
                              _ line: Int = #line) {
        
        Log.sharedInstance.verbose(verbose, file, function, line)
    }
    
    public class func debug(_ debug: Any,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line) {
        
        Log.sharedInstance.debug(debug, file, function, line)
    }
    
    public class func warning(_ warning: Any,
                              _ file: String = #file,
                              _ function: String = #function,
                              _ line: Int = #line) {
        Log.sharedInstance.warning(warning, file, function, line)
    }
}
