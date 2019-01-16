//
//  MasterViewController.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import UIKit

enum Section: String, CaseIterable {
    case examples
    case actions
    
    var title: String {
        return self.rawValue.uppercased()
    }
}

enum Action: CaseIterable {
    case clearCaches
    case clearDownloads
    case resetiPadDetail
    
    static let sectionTitle = "Actions"
    
    var title: String {
        switch self {
        case .clearCaches:
            return "Clear everything from Caches"
        case .clearDownloads:
            return "Clear everything from Downloads"
        case .resetiPadDetail:
            return "Reset iPad Detail View"
        }
    }
}

class MasterViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = Section.allCases[section]
        switch sectionType {
        case .examples:
            return Example.allCases.count
        case .actions:
            return Action.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = Section.allCases[section]
        return sectionType.title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .examples:
            let example = Example.allCases[indexPath.row]
            cell.textLabel?.text = example.description
        case .actions:
            let action = Action.allCases[indexPath.row]
            cell.textLabel?.text = action.title
        }
        
        return cell
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .examples:
            let example = Example.allCases[indexPath.row]
            self.handleSelectedExample(example)
        case .actions:
            let action = Action.allCases[indexPath.row]
            self.handleSelectedAction(action)
        }
    }
    
    private func handleSelectedExample(_ example: Example) {
        guard let secondaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SecondaryViewController.self)) as? SecondaryViewController else {
            assertionFailure("Couldn't grab secondary VC!")
            return
        }
        
        secondaryVC.example = example        
        self.navigationController?.pushViewController(secondaryVC, animated: true)
    }
    
    private func handleSelectedAction(_ action: Action) {
        switch action {
        case .clearCaches:
            do {
                try FileManager.default.removeContentsOfFolder(at: FilePathHelper.pathToCachesDirectory)
            } catch {
                debugPrint("Error clearing caches: \(error)")
            }
        case .clearDownloads:
            do {
                try FileManager.default.removeContentsOfFolder(at: FilePathHelper.pathToDocumentsDirectory)
            } catch {
                debugPrint("Error clearing documents")
            }
        case .resetiPadDetail:
            guard let split = self.splitViewController else {
                debugPrint("Ceçi ce n'est pas une iPad.")
                return
            }
            
            let detail = self.loadNewDetailVC()
            self.replaceExistingDetailVC(in: split, with: detail)
        }
    }
}

