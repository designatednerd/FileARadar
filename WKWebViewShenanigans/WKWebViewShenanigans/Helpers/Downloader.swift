//
//  Downloader.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import Foundation

struct Downloader {
    
    enum DownloadError: Error {
        case noData
        case emptyData
        case inappropriateResponseType
        case invalidResponseCode(Int)
    }
    
    static func downloadFrom(_ webURL: URL,
                             to fileURL: URL,
                             errorCompletion: @escaping (Error) -> Void,
                             successCompletion: @escaping (URL) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: webURL) { (data, response, error) in
            var errorToReturn: Error?
            defer {
                if let returnError = errorToReturn {
                    DispatchQueue.main.async {
                        errorCompletion(returnError)
                    }
                } else {
                    DispatchQueue.main.async {
                        successCompletion(fileURL)
                    }
                }
            }
            
            if let error = error {
                errorToReturn = error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                errorToReturn = DownloadError.inappropriateResponseType
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                errorToReturn = DownloadError.invalidResponseCode(httpResponse.statusCode)
                return
            }
            
            
            guard let data = data else {
                errorToReturn = DownloadError.noData
                return
            }
            
            guard !data.isEmpty else {
                errorToReturn = DownloadError.emptyData
                return
            }
            
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error writing data to file! \(error)")
                errorToReturn = error
            }
        }
        
        task.resume()
    
        return task
    }   
}
