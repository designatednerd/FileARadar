//
//  ExampleSelectionViewController.swift
//  GroupedTableViewExtraSpace
//
//  Created by Ellen Shapiro (Work) on 6/10/18.
//  Copyright © 2018 DesignatedNerd. All rights reserved.
//

import UIKit

enum GroupedTableView: Int {
    case noHeaders
    case sectionHeaders
    case sectionHeadersWithWorkaround

    /// BUT I WANT `CaseIterable` NOOOOOOOW
    static var allCases = [
        GroupedTableView.noHeaders,
        GroupedTableView.sectionHeaders,
        GroupedTableView.sectionHeadersWithWorkaround,
    ]

    static func forIndex(_ index: Int) -> GroupedTableView {
        guard let found = GroupedTableView(rawValue: index) else {
            fatalError("Not a valid index")
        }

        return found
    }

    var title: String {
        switch self {
        case .noHeaders:
            return "Grouped UITV, No Headers"
        case .sectionHeaders:
            return "Grouped UITV, Section Headers"
        case .sectionHeadersWithWorkaround:
            return "Grouped UITV, Section + Workaround"
        }
    }
}

class ExampleSelectionViewController: UITableViewController {

    private let reuseIdentifier = "reuse"

//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        return tableView
//    }()


    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Examples"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)


//        self.view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
//        ])

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupedTableView.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let item = GroupedTableView.forIndex(indexPath.row)

        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerToPush: UIViewController
        switch GroupedTableView.forIndex(indexPath.row) {
        case .noHeaders:
            viewControllerToPush = GroupedTableViewNoSectionHeaders()
        case .sectionHeaders:
            viewControllerToPush = GroupedTableViewWithSectionHeaders()
        case .sectionHeadersWithWorkaround:
            viewControllerToPush = GroupedTableViewWithSectionHeadersAndWorkaround()
        }

        self.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
}
