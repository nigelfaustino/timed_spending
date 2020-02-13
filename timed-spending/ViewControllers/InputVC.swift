//
//  InputVC.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia
import CoreData

class InputVC: UIViewController {
    private var costTextField: CurrencyField = {
        let textField = CurrencyField(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        textField.layer.borderColor = UIColor.white.cgColor
        textField.font = UIFont.systemFont(ofSize: 40)
        textField.textColor = .white
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()

    private var itemTextField: CustomTextField = {
        let textField = CustomTextField(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        textField.placeholder("Transaction Name")
        return textField
    }()

    private var categoryTextField: CustomTextField = {
        let textField = CustomTextField(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textAlignment = .center
        textField.placeholder("Category Name")
        textField.layer.cornerRadius = 5
        return textField
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return button
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.backgroundColor = UIColor.white.cgColor
        picker.isHidden = true
        return picker
    }()

    private var categories: [String] = ["Shopping", "Food and Drink", "Travel", "Groceries", "Gas", "Bills and Utilities", "Miscellaneous"]

    private var categoryIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.sv(costTextField,
                itemTextField,
                categoryTextField,
                button,
                picker
        )
        categoryTextField.delegate = self
        picker.dataSource = self
        picker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelEditing(sender:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViews()
        setGradientBackground(UIColor(red: 0.20, green: 0.50, blue: 0.84, alpha: 1.0), UIColor(red: 0.53, green: 0.95, blue: 0.95, alpha: 1.0))
    }

    private func layoutViews() {
        view.layer.backgroundColor = UIColor.blue.cgColor
        itemTextField.centerInContainer().left(40)
        costTextField.Bottom == itemTextField.Top - 20
        costTextField.Width == itemTextField.Width
        costTextField.centerHorizontally()
        categoryTextField.Top == itemTextField.Bottom + 20
        categoryTextField.Width == itemTextField.Width
        categoryTextField.centerHorizontally()
        button.centerHorizontally()
        button.Top == categoryTextField.Bottom + 10
        picker.bottom(0).left(0).right(0)
    }

    @objc private func submitButtonPressed() {
        let cost = costTextField.doubleValue
        guard let itemName = itemTextField.text, itemTextField.text?.count ?? 0 > 0 else { return }
        guard let category = categoryTextField.text else { return }
        let categories = Profile.currentProfile.transactionCategories
        let transaction = Transaction(itemName, cost, category)
        categories[categoryIndex].transactions.append(transaction)
        itemTextField.text = ""
        costTextField.text = "$0.00"
    }

    @objc private func cancelEditing(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension InputVC: UIPickerViewDataSource, UIPickerViewDelegate {
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
        categoryTextField.text = categories[row]
        categoryIndex = row
        picker.isHidden = true
    }
}

extension InputVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        picker.isHidden = false
        picker.becomeFirstResponder()
        return false
    }
}
