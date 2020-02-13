//
//  Transaction.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation

class Transaction {
    var itemName: String
    var cost: Double
    var category: String

    init(_ name: String, _ cost: Double, _ category: String) {
        self.itemName = name
        self.cost = cost
        self.category = category
    }
}
