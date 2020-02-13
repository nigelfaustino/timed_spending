    //
//  UIViewController Extension.swift
//  timed-spending
//
//  Created by NIGEL FAUSTINO on 2/12/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setGradientBackground(_ topColor: UIColor, _ bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
