//
//  AppColor.swift
//  TripTogether
//
//  Created by 정기현 on 2024/06/05.
//

import UIKit

extension UIColor {
    static let appColor: UIColor = {
        let redValue: CGFloat = 30 / 255.0
        let greenValue: CGFloat = 258 / 255.0
        let blueValue: CGFloat = 249 / 255.0
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }()
}
