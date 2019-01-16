//
//  Document.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import Foundation

struct Document: Equatable {
    
    let urlString: String
    
    var url: URL {
        guard let url = URL(string: self.urlString) else {
            fatalError("Couldn't make a URL from \(self.urlString)")
        }
        
        return url
    }
    
    var fileName: String {
        return self.url.lastPathComponent
    }
    
    var isCached: Bool {
        return FileManager.default.fileExistsAtPath(self.cachePath)
    }
    
    var cachePath: String {
        return FilePathHelper.path(in: FilePathHelper.pathToCachesDirectory, for: self.fileName)
    }
    
    var cacheFileURL: URL {
        return URL(fileURLWithPath: self.cachePath)
    }
    
    var isDownloaded: Bool {
        return FileManager.default.fileExistsAtPath(self.downloadPath)
    }
    
    var downloadPath: String {
        return FilePathHelper.path(in: FilePathHelper.pathToDocumentsDirectory, for: self.fileName)
    }
    
    var downloadFileURL: URL {
        return URL(fileURLWithPath: self.downloadPath)
    }
    
    static let iOSSecurityGuide = Document(urlString: "https://www.apple.com/business/site/docs/iOS_Security_Guide.pdf")
    
    static let macOSSecurityGuide = Document(urlString: "https://www.apple.com/business/resources/docs/macOS_Security_Overview.pdf")
    
    static let appleTV1stGenSetupGuide = Document(urlString: "https://manuals.info.apple.com/MANUALS/0/MA403/en_US/AppleTV_SetupGuide.pdf")
    
    static let appleTV2ndGenSetupGuide = Document(urlString: "https://manuals.info.apple.com/MANUALS/1000/MA1555/en_US/Apple_TV_2nd_gen_Setup_Guide.pdf")
    
    static let appleTV3rdGenSetupGuide = Document(urlString: "https://manuals.info.apple.com/MANUALS/1000/MA1607/en_US/apple_tv_3rd_gen_setup.pdf")
}
