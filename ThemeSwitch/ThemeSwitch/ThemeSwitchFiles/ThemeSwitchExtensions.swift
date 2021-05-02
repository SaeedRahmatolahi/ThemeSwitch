//
//  ThemeSwitchExtensions.swift
//  ThemeSwitch
//
//  Created by Saeed Rahmatolahi on 2/5/2564 BE.
//

import Foundation
import UIKit

extension UIButton {
    func setButtonImage(_ image : UIImage?) {
        self.setImage(image ?? UIImage(), for: .normal)
    }
}
