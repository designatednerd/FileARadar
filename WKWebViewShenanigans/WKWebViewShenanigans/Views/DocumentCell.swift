//
//  DocumentCell.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import UIKit

protocol DocumentCellDelegate: class {
    func loadDocumentFromCaches(_ document: Document)
    func loadDocumentFromDocuments(_ document: Document)
}

class DocumentCell: UITableViewCell {
    
    @IBOutlet private(set) var nameLabel: UILabel!
    
    var document: Document? {
        didSet {
            self.configureForCurrentDocument()
        }
    }
    
    weak var delegate: DocumentCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.document = nil
        self.delegate = nil
    }
    
    func configureForCurrentDocument() {
        if let document = self.document {
            self.nameLabel.text = document.fileName
        } else {
            self.nameLabel.text = nil
        }
    }
    
    @IBAction private func loadFromCaches() {
        guard let doc = self.document else {
            return
        }
        
        self.delegate?.loadDocumentFromCaches(doc)
    }
    
    @IBAction private func loadFromDocuments() {
        guard let doc = self.document else {
            return
        }
        
        self.delegate?.loadDocumentFromDocuments(doc)
    }
}
