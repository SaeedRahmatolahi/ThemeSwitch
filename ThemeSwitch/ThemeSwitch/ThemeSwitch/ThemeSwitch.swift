//
//  ThemeSwitch.swift
//  ThemeSwitch
//
//  Created by Saeed Rahmatolahi on 2/5/2564 BE.
//

import UIKit

class ThemeSwitch: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backGroundButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundEffect: UIImageView!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var effectTopCons: NSLayoutConstraint!
    @IBOutlet weak var effectBottomCons: NSLayoutConstraint!
    @IBOutlet weak var effectRightCons: NSLayoutConstraint!
    weak var themeSwitchDelegate : themeSwitchProtocol?
    var themeConfiguration = ThemeConfiguration() {
        didSet {
            themeSettings()
        }
    }
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupLayouts()
    }
    
    fileprivate func setupLayouts() {
        switchButton.addTarget(self, action: #selector(switchChanged), for: .touchUpInside)
        backGroundButton.addTarget(self, action: #selector(switchChanged), for: .touchUpInside)
        backgroundView.layer.cornerRadius = self.frame.size.height / 2
        themeSettings()
    }
    
    @objc fileprivate func switchChanged() {
        self.themeSwitchDelegate?.themeChanged(theme: self.themeConfiguration.theme == .dark ? self.themeConfiguration.isDarkThemeRight ? .dark : .light : self.themeConfiguration.isDarkThemeRight ? .light : .dark)
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.themeConfiguration.animationDuration) {
                self.themeConfiguration.theme == .dark ? (self.leftConstraint.constant = self.frame.size.width - (self.frame.size.height - (self.themeConfiguration.margin * 2)) - self.themeConfiguration.margin) : (self.leftConstraint.constant = self.themeConfiguration.margin)
                self.themeConfiguration.theme == .dark ? (self.effectRightCons.constant = self.frame.size.width - (self.frame.size.height - (self.themeConfiguration.margin * 2)) - self.themeConfiguration.margin) : (self.effectRightCons.constant = self.themeConfiguration.margin)
                self.layoutIfNeeded()
            }
            UIView.animate(withDuration: self.themeConfiguration.animationDuration) {
                self.themeConfiguration.theme == .dark ? (self.switchButton.transform = CGAffineTransform.identity.rotated(by: self.themeConfiguration.lightRotation)) : (self.switchButton.transform = CGAffineTransform.identity.rotated(by: self.themeConfiguration.darkRotation))
                self.backgroundView.backgroundColor = self.themeConfiguration.theme == .dark ? self.themeConfiguration.lightColor : self.themeConfiguration.darkColor
            }
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + themeConfiguration.animationDuration / 2) {
            UIView.transition(with: self.switchButton, duration: self.themeConfiguration.animationDuration / 2, options: .curveLinear, animations: {
                self.switchButton.setButtonImage(self.themeConfiguration.theme == .dark ? self.themeConfiguration.lightImage : self.themeConfiguration.darkImage)
                        }, completion: nil)
            self.themeConfiguration.theme == .dark ? (self.backgroundEffect.image = self.themeConfiguration.lightEffect) : (self.backgroundEffect.image = self.themeConfiguration.darkEffect)
            self.themeConfiguration.theme = self.themeConfiguration.theme == .dark ? .light : .dark
        }
        
    }
    
    fileprivate func themeSettings() {
        self.switchButton.setButtonImage(self.themeConfiguration.theme == .light ? self.themeConfiguration.lightImage : self.themeConfiguration.darkImage)
        self.backgroundEffect.image = self.themeConfiguration.theme == .light ? self.themeConfiguration.lightEffect : self.themeConfiguration.darkEffect
        self.themeConfiguration.theme == .light ? (self.leftConstraint.constant = self.frame.size.width - (self.frame.size.height - (self.themeConfiguration.margin * 2)) - self.themeConfiguration.margin) : (self.leftConstraint.constant = self.themeConfiguration.margin)
        self.themeConfiguration.theme == .light ? (self.effectRightCons.constant = self.frame.size.width - (self.frame.size.height - (self.themeConfiguration.margin * 2)) - self.themeConfiguration.margin) : (self.effectRightCons.constant = self.themeConfiguration.margin)
        self.topConstraint.constant = self.themeConfiguration.margin
        self.bottomConstraint.constant = self.themeConfiguration.margin
        self.effectTopCons.constant = self.themeConfiguration.margin
        self.effectBottomCons.constant = self.themeConfiguration.margin
        self.themeConfiguration.theme == .light ? (self.switchButton.transform = CGAffineTransform.identity.rotated(by: self.themeConfiguration.lightRotation)) : (self.switchButton.transform = CGAffineTransform.identity.rotated(by: self.themeConfiguration.darkRotation))
        self.backgroundView.backgroundColor = self.themeConfiguration.theme == .light ? self.themeConfiguration.lightColor : self.themeConfiguration.darkColor
    }
    
    fileprivate func commonInit() {
        let bundle = Bundle.init(for: ThemeSwitch.self)
        guard let viewsToAdd = bundle.loadNibNamed("ThemeSwitch", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView  else { return }
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

}


protocol themeSwitchProtocol : NSObjectProtocol {
    func themeChanged(theme : theme)
}

enum theme {
    case dark
    case light
}
