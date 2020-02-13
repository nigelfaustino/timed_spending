//
//  SummaryVC.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia

class SummaryVC: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "Your spending summary"
        return label
    }()

    private let tableView = UITableView()

    private let totalCostView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.white.cgColor
        return view
    }()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Total Spent"
        return label
    }()

    private let costLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private var categories: [TransactionCategory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Profile.currentProfile.transactionCategories
        view.layer.backgroundColor = UIColor.purple.cgColor
        view.sv(
            titleLabel,
            tableView,
            totalCostView.sv(
                totalLabel,
                costLabel
            )
        )
        tableView.dataSource = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "reuse")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        var cost = 0.0
        for category in categories {
            for transaction in category.transactions {
                cost += transaction.cost
            }
        }
        costLabel.text = "$" + String(format: "%.2f", cost)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
        setGradientBackground(UIColor(red: 0.37, green: 0.08, blue: 0.86, alpha: 1.0), UIColor(red: 0.21, green: 0.55, blue: 0.97, alpha: 1.0))
    }

    private func layoutViews() {
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.size.height else { return }
        titleLabel.left(20).top(50)
        tableView.Top == titleLabel.Bottom + 40
        tableView.left(20).right(20)
        totalCostView.Top == tableView.Bottom
        totalCostView.bottom(tabBarHeight + 40).left(20).right(20)
        totalLabel.left(10).top(20).bottom(20)
        costLabel.right(10).top(20).bottom(20)
    }
}

extension SummaryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as! CategoryCell
        cell.configure(categories[indexPath.row])
        return cell
    }
}
