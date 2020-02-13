//
//  CustomTextField.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 2/12/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    var padding = UIEdgeInsets.zero

    init(_ padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
