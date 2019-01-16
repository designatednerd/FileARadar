//
//  SecondaryViewController.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import UIKit

class SecondaryViewController: UITableViewController {
    
    var documents = [
        Document.iOSSecurityGuide,
        Document.macOSSecurityGuide,
        Document.appleTV1stGenSetupGuide,
        Document.appleTV2ndGenSetupGuide,
        Document.appleTV3rdGenSetupGuide
    ]
    
    var example: Example!
    private var currentTask: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    private func cacheIfNeededThenOpen(_ document: Document) {
        guard !document.isCached else {
            self.showFile(at: document.cacheFileURL)
            return
        }
        
        self.getDocumentFromInternet(document,
                                     to: document.cacheFileURL)
    }
    
    private func downloadIfNeededThenOpen(_ document: Document) {
        guard !document.isDownloaded else {
            self.showFile(at: document.downloadFileURL)
            return
        }
        
        self.getDocumentFromInternet(document,
                                     to: document.downloadFileURL)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.documents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DocumentCell.self), for: indexPath) as? DocumentCell else {
            return UITableViewCell()
        }
        
        let document = self.documents[indexPath.row]
        cell.document = document
        cell.delegate = self
        
        return cell
    }
    
    private func getDocumentFromInternet(_ document: Document, to fileURL: URL) {
        self.currentTask = Downloader.downloadFrom(
            document.url,
            to: fileURL,
            errorCompletion: { [weak self] error in
                debugPrint("Error: \(error)")
                guard let self = self else {
                    return
                }
                
                self.currentTask = nil
                self.tableView.reloadData()
            },
            successCompletion: { [weak self] url in
                guard let self = self else {
                    return
                }
                
                self.currentTask = nil
                self.tableView.reloadData()
                self.showFile(at: url)
            })
    }

    private func showFile(at fileURL: URL) {
        if let splitVC = self.splitViewController {
            if self.example! == .recreateEveryTimeSettingFileURL {
                let detail = self.loadNewDetailVC()
                self.replaceExistingDetailVC(in: splitVC, with: detail)
                detail.afterViewLoadedAction = { [weak self] in
                    self?.showFile(at: fileURL, in: detail)
                }
                debugPrint("Created brand new detail view controller on iPad!")
            } else {
                let detail = self.getExistingDetailVC(from: splitVC)
                self.showFile(at: fileURL, in: detail)
                debugPrint("Grabbed existing detail view controller!")
            }
        } else {
            let detail = self.loadNewDetailVC()
            detail.afterViewLoadedAction = { [weak self] in
                self?.showFile(at: fileURL, in: detail)
            }
            debugPrint("Created brand new detail view controller on iPhone!")
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    private func showFile(at fileURL: URL, in detailVC: DetailViewController) {
        
        switch self.example! {
        case .usingURLRequest:
            let urlRequest = URLRequest(url: fileURL)
            detailVC.loadURLRequest(urlRequest)
        case .settingCachesFolderInFirstRequest:
            detailVC.loadDocument(fileURL: fileURL, folderURL: FilePathHelper.cachesURL)
        case .settingDocumentsFolderInFirstRequest:
            detailVC.loadDocument(fileURL: fileURL, folderURL: FilePathHelper.documentsURL)
        case .settingAppSandboxFolderInFirstRequest:
            detailVC.loadDocument(fileURL: fileURL, folderURL: FilePathHelper.appSandboxURL)
        case .settingFileURLInFirstRequest,
             .recreateEveryTimeSettingFileURL:
            detailVC.loadDocument(fileURL: fileURL)
        }
        
        detailVC.title = self.example.title
        detailVC.expectedBehaviorLabel.text = self.example.expectedBehavior
    }
}

extension SecondaryViewController: DocumentCellDelegate {
    
    func loadDocumentFromCaches(_ document: Document) {
        self.cacheIfNeededThenOpen(document)
    }
    
    func loadDocumentFromDocuments(_ document: Document) {
        self.downloadIfNeededThenOpen(document)
    }
}
