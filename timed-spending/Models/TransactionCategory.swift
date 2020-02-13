//
//  TransactionCategory.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation

enum TransactionType: String, CaseIterable {
    case shopping = "Shopping"
    case food = "Food and Drink"
    case travel = "Travel"
    case groceries = "Groceries"
    case gas = "Gas"
    case bills = "Bills and Utilities"
    case miscellaneous = "Miscellaneous"
}

class TransactionCategory {
    var type: TransactionType
    var transactions: [Transaction]

    init(_ type: TransactionType = .shopping) {
        self.type = type
        transactions = []
    }
}
