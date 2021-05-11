//
//  Theme.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import UIKit

enum Theme {
    enum Colors {
        static let primary = #colorLiteral(red: 0.9215686275, green: 0.431372549, blue: 0.2980392157, alpha: 1)
        static let titleText = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9)
        static let standardText = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 0.9)
        static let buttonText = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let navigationBackground = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 0.9)
        static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9)
        static let cellTitle = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
    }

    enum Fonts {
        static let title = UIFont.appFont(ofSize: 40)
        static let navigationtitle = UIFont.appFont(ofSize: 34)
        static let dateText = UIFont.appFont(ofSize: 24)
        static let cityText = UIFont.appFont(ofSize: 20)
        static let standard = UIFont.appFont(ofSize: 9)
        static let standardBold = UIFont.appFont(ofSize: 16)
    }

    enum Images {
        static let backgroundImage = #imageLiteral(resourceName: "logo")
    }

    enum Constants {
        static let cornerRadius = CGFloat(10)
        static let padding = CGFloat(8)
        static let margin  = CGFloat(15)

    }
}

extension UIFont {
    static func appFont(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: "Helvetica-Bold", size: fontSize)!
    }
}
