//
//  CustomButton.swift
//  CustomUIButton
//
//  Created by Cedan Misquith on 16/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var borderView: CALayer?
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.borderView = border
        self.layer.addSublayer(border)
    }
    
    func removeBorder(){
        self.borderView?.removeFromSuperlayer()
    }
}
