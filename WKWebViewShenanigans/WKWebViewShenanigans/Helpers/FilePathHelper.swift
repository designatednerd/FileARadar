//
//  FilePathHelper.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import Foundation

struct FilePathHelper {
    
    // make init private to avoid instantiaton of helper class
    private init() {}
    
    static var appSandboxURL: URL {
        // Obviously this assumes that documents is a direct descendant of the sandbox
        return self.documentsURL.deletingLastPathComponent()
    }
    
    static var cachesURL: URL {
        return URL(fileURLWithPath: self.pathToCachesDirectory)
    }
    
    static var pathToCachesDirectory: String {
        guard let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            fatalError("Could not access caches directory")
        }
        
        return cachesDirectory
    }
    
    static var documentsURL: URL {
        return URL(fileURLWithPath: self.pathToDocumentsDirectory)
    }
    
    static var pathToDocumentsDirectory: String {
        guard let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("Could not access documents directory")
        }
        
        return documentsDirectory
    }
    
    static func path(in directoryPath: String, for fileName: String) -> String {
        return (directoryPath as NSString).appendingPathComponent(fileName)
    }
}
