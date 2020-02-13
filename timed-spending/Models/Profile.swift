//
//  Profile.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation

class Profile {
    static let currentProfile = Profile()
    var transactionCategories: [TransactionCategory]

//    //    case shopping = "Shopping"
//    case food = "Food and Drink"
//    case travel = "Travel"
//    case groceries = "Groceries"
//    case gas = "Gas"
//    case bills = "Bills and Utilities"
//    case miscellaneous = "Miscellaenous"


    private init() {
        transactionCategories = [TransactionCategory(.shopping),
                                 TransactionCategory(.food),
                                 TransactionCategory(.travel),
                                 TransactionCategory(.groceries),
                                 TransactionCategory(.gas),
                                 TransactionCategory(.bills),
                                 TransactionCategory(.miscellaneous)]
    }
}
