//
//  ThemeConfiguration.swift
//  ThemeSwitch
//
//  Created by Saeed Rahmatolahi on 2/5/2564 BE.
//

import UIKit

struct ThemeConfiguration {
    var theme : theme = .light
    var animationDuration : TimeInterval = 0.3
    var lightImage : UIImage = UIImage(named: "sun") ?? UIImage()
    var darkImage : UIImage = UIImage(named: "moon") ?? UIImage()
    var lightEffect : UIImage = UIImage(named: "cloud") ?? UIImage()
    var darkEffect : UIImage = UIImage(named: "stars") ?? UIImage()
    var lightColor : UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    var darkColor : UIColor = #colorLiteral(red: 0.03777536377, green: 0.1315395236, blue: 0.2186227143, alpha: 1)
    var margin : CGFloat = 3
    var lightRotation : CGFloat = .pi
    var darkRotation : CGFloat = -2 * .pi
    var isDarkThemeRight : Bool = false {
        didSet {
            isDarkThemeRight ? (theme == .light ? (theme = .dark) : (theme = .light)): nil
            (lightImage,darkImage) = isDarkThemeRight ? (darkImage,lightImage) : (lightImage,darkImage)
            (lightEffect,darkEffect) = isDarkThemeRight ? (darkEffect,lightEffect) : (lightEffect,darkEffect)
            (lightColor,darkColor) = isDarkThemeRight ? (darkColor,lightColor) : (lightColor,darkColor)
            (lightRotation,darkRotation) = isDarkThemeRight ? (darkRotation,lightRotation) : (lightRotation,darkRotation)
        }
    }
}
