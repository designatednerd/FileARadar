//
//  GroupedTableViewWithSectionHeadersAndWorkaround.swift
//  GroupedTableViewExtraSpace
//
//  Created by Ellen Shapiro (Work) on 6/10/18.
//  Copyright © 2018 DesignatedNerd. All rights reserved.
//

import UIKit

class GroupedTableViewWithSectionHeadersAndWorkaround: UIViewController {
    private let reuseIdentifier = "reuse"

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Section Headers + Workaround"

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])

        let workaroundView = UIView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: tableView.frame.width,
                                                               height: CGFloat.leastNormalMagnitude)))
        tableView.tableHeaderView = workaroundView
    }
}

extension GroupedTableViewWithSectionHeadersAndWorkaround: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cell.textLabel?.text = "Row \(indexPath.row) in section \(indexPath.section)"

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

}

extension GroupedTableViewWithSectionHeadersAndWorkaround: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row) in section \(indexPath.section)")
    }
}
