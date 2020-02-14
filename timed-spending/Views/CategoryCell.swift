//
//  CategoryCell.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia

class CategoryCell: UITableViewCell {
    private let categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let costLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        sv(categoryLabel,
           costLabel
        )
        categoryLabel.centerVertically().left(10).top(20)
        costLabel.centerVertically().right(10)
    }

    func configure(_ category: TransactionCategory) {
        categoryLabel.text = category.type.rawValue
        var cost = 0.0
        for transaction in category.transactions {
            cost += transaction.cost
        }
        costLabel.text = "$" + String(format: "%.2f", cost)
    }
}
