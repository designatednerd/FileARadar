//
//  FileManager+Helpers.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import Foundation

extension FileManager {
    
    func fileExistsAtPath(_ path: String) -> Bool {
        var isDirectoryPointer: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectoryPointer)
        
        return exists && !isDirectoryPointer.boolValue
    }
    
    func removeContentsOfFolder(at path: String) throws {
        let contents = try self.contentsOfDirectory(atPath: path)
        try contents.forEach { item in
            let fullPath = FilePathHelper.path(in: path, for: item)
            try self.removeItem(atPath: fullPath)
        }
    }
}
