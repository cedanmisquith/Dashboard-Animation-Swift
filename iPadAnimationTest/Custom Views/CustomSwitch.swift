//
//  CustomSwitch.swift
//  iPadAnimationTest
//
//  Created by Cedan Misquith on 16/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit

protocol SwitchDelegateProtocol {
    func isSwitch(on: Bool)
}

class CustomSwitch: UIView{
    
    var toggleView: UIView?
    var statusLabel: UILabel?
    var isSwitchOn: Bool = false
    var switchButton: UIButton?
    var switchDelegate: SwitchDelegateProtocol?
        
    override func awakeFromNib(){
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.64).cgColor
        self.layer.cornerRadius = 12.5
        
        statusLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.width-18, height: 25))
        statusLabel?.textColor = .white
        statusLabel?.text = "OFF"
        statusLabel?.textAlignment = .right
        statusLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(statusLabel!)
        
        toggleView = UIView(frame: CGRect(x: 5, y: 4, width: 16, height: 16))
        toggleView?.layer.cornerRadius = 8
        toggleView?.backgroundColor = UIColor.white.withAlphaComponent(0.64)
        self.addSubview(toggleView!)
        
        switchButton = UIButton(frame: self.bounds)
        switchButton?.addTarget(self, action: #selector(switchToggledAction), for: .touchUpInside)
        self.addSubview(switchButton!)
        
    }
    
    @objc func switchToggledAction(sender: UIButton!){
        print("Switch Toggled")
        if isSwitchOn{
            statusLabel?.text = "OFF"
            statusLabel?.textAlignment = .right
            UIView.animate(withDuration: 0.2) {
                self.toggleView?.frame = CGRect(x: 5, y: 4, width: 16, height: 16)
            }
            toggleView?.backgroundColor = UIColor.white.withAlphaComponent(0.64)
            self.layer.borderColor = UIColor.white.withAlphaComponent(0.64).cgColor
            isSwitchOn = false
            self.switchDelegate?.isSwitch(on: isSwitchOn)
        }else{
            statusLabel?.text = "ON"
            statusLabel?.textAlignment = .left
            UIView.animate(withDuration: 0.2) {
                self.toggleView?.frame = CGRect(x: 39, y: 4, width: 16, height: 16)
            }
            toggleView?.backgroundColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF")
            self.layer.borderColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF").cgColor
            isSwitchOn = true
            self.switchDelegate?.isSwitch(on: isSwitchOn)
        }
    }
}
