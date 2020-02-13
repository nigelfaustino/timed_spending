//
//  TransactionCell.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 1/17/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia

class TransactionCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
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
        sv(nameLabel,
           categoryLabel,
           costLabel
           )
        nameLabel.left(10).top(10)
        categoryLabel.Top == nameLabel.Bottom + 10
        categoryLabel.bottom(10).left(10)
        costLabel.centerVertically().right(10)
    }

    func configure(_ transaction: Transaction) {
        nameLabel.text = transaction.itemName
        categoryLabel.text = transaction.category
        costLabel.text = "$" + String(format: "%.2f", transaction.cost)
    }
}
