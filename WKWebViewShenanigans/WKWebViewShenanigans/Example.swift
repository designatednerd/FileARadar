//
//  Example.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import Foundation

enum Example: Int, CaseIterable {
    case usingURLRequest
    case settingCachesFolderInFirstRequest
    case settingDocumentsFolderInFirstRequest
    case settingAppSandboxFolderInFirstRequest
    case settingFileURLInFirstRequest
    case recreateEveryTimeSettingFileURL
    
    var description: String {
        switch self {
        case .usingURLRequest:
            return "Loading with `load(urlRequest:)` for a local File URL"
        case .settingFileURLInFirstRequest:
            return "Loading with `loadFileURL(_, allowingReadAccessTo:_)` and setting the first selected file's URL as the URL with read access"
        case .settingCachesFolderInFirstRequest:
            return "Loading with `loadFileURL(_, allowingReadAccessTo:_)` and setting the User Caches folder as the URL with read access"
        case .settingDocumentsFolderInFirstRequest:
            return "Loading with `loadFileURL(_, allowingReadAccessTo:_)` and setting the User Documents folder as the URL with read access"
        case .settingAppSandboxFolderInFirstRequest:
            return "Loading with `loadFileURL(_, allowingReadAccessTo:_)` and setting the application Sandbox folder as the URL with read access"
        case .recreateEveryTimeSettingFileURL:
            return "Loading with `loadFileURL(_, allowingReadAccessTo:_)` but recreating the Detail VC (and thus the web view) every time a new document is selected"
        }
    }
    
    var title: String {
        switch self {
        case .usingURLRequest:
            return "Using URL Requests"
        case .settingCachesFolderInFirstRequest:
            return "Caches folder gets read access in first request"
        case .settingDocumentsFolderInFirstRequest:
            return "Documents folder gets read access in first request"
        case .settingAppSandboxFolderInFirstRequest:
            return "App sandbox gets read access in first request"
        case .settingFileURLInFirstRequest:
            return "File URL gets read access in first request (not recreated on iPad)"
        case .recreateEveryTimeSettingFileURL:
            return "File URL gets read access in first request (recreated on iPad)"
        }
    }
    
    var expectedBehavior: String {
        switch self {
        case .usingURLRequest:
            return """
            On Simulator:
            This works fine from either Documents or Caches
            
            On iPhone or iPad Device:
            Does not work at all.
            """
        case .settingCachesFolderInFirstRequest:
            return """
            On Simulator:
            Works fine, though it prints a \"Received an unexpected URL from the web process\" error.
            
            On iPhone Device:
            This works fine since the detail VC is recreated every time a new document is selected.
            
            On iPad Device:
            This allows only loading documents from the Caches folder. Attempting to load anything from the Documents folder will fail with a security error.
            """
        case .settingDocumentsFolderInFirstRequest:
            return """
            On Simulator:
            Works fine, though it prints a \"Received an unexpected URL from the web process\" error.
            
            On iPhone Device:
            This works fine since the detail VC is recreated every time a new document is selected.
            
            On iPad Device:
            This allows only loading documents from the Documents folder. Attempting to load anything from the Caches folder will fail with a security error.
            """
        case .settingAppSandboxFolderInFirstRequest:
            return """
            On Simulator:
            Works fine.
            
            On iPhone or iPad Device:
            Attempting to load anything from any folder will fail with a security error.
            """
        case .settingFileURLInFirstRequest:
            return """
            On Simulator:
            Works fine, though it prints a \"Received an unexpected URL from the web process\" error.
            
            On iPhone Device:
            This works fine since the detail VC is recreated every time a new document is selected.
            
            On iPad Device:
            This allows only loading the first document selected, and only from the folder where it was first selected Attempting to load anything else will fail with a security error.
            """
        case .recreateEveryTimeSettingFileURL:
            return """
            On Simulator:
            Works fine.
            
            On iPad or iPhone Device:
            This VC is recreated every single time it's viewed, so even though only the current document is set as the URL with read permissions, it works fine.
            """
        }
    }
}
