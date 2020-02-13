//
//  TransactionsVC.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia

class TransactionsVC: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "Your transactions"
        return label
    }()

    private let filterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Filter by:"
        return label
    }()

    private let textField: CustomTextField = {
        let textField = CustomTextField(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.text = "All"
        return textField
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.backgroundColor = UIColor.white.cgColor
        picker.isHidden = true
        return picker
    }()

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

    private let tableView = UITableView()

    private var transactions = [Transaction]()

    private var categories: [String] = ["Shopping", "Food and Drink", "Travel", "Groceries", "Gas", "Bills and Utilities", "Miscellaneous"]

    private var categoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor.orange.cgColor
        view.sv(
            titleLabel,
            filterLabel,
            textField,
            tableView,
            totalCostView.sv(
                totalLabel,
                costLabel
            ),
            picker
        )
        for category in Profile.currentProfile.transactionCategories {
            for transaction in category.transactions {
                transactions.append(transaction)
            }
        }
        tableView.dataSource = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "reuse")
        picker.dataSource = self
        picker.delegate = self
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        sumTransactions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
        setGradientBackground(UIColor(red: 0.95, green: 0.21, blue: 0.26, alpha: 1.0), UIColor(red: 0.96, green: 0.59, blue: 0.02, alpha: 1.0)
)
    }

    private func layoutViews() {
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.size.height else { return }
        titleLabel.left(20).top(50)
        filterLabel.Top == titleLabel.Bottom + 40
        filterLabel.left(20)
        textField.Top == filterLabel.Top - 5
        textField.Left == filterLabel.Right + 10
        tableView.Top == textField.Bottom + 10
        tableView.left(20).right(20)
        totalCostView.Top == tableView.Bottom
        totalCostView.bottom(tabBarHeight + 40).left(20).right(20)
        totalLabel.left(10).top(20).bottom(20)
        costLabel.right(10).top(20).bottom(20)
        picker.bottom(tabBarHeight).height(80).left(0).right(0)
    }

    private func sumTransactions() {
        var cost = 0.0
        for transaction in transactions {
            cost += transaction.cost
        }
        costLabel.text = "$" + String(format: "%.2f", cost)
    }

    private func filter(_ categoryIndex: Int) {
        transactions = Profile.currentProfile.transactionCategories[categoryIndex].transactions
        tableView.reloadData()
        sumTransactions()
    }
}

extension TransactionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as! TransactionCell
        cell.configure(transactions[indexPath.row])
        return cell
    }
}

extension TransactionsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        textField.text = categories[row]
        categoryIndex = row
        picker.isHidden = true
        filter(row)
    }
}

extension TransactionsVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        picker.isHidden = false
        picker.becomeFirstResponder()
        return false
    }
}
