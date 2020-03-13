//
//  Utilities.swift
//  iPadAnimationTest
//
//  Created by Cedan Misquith on 14/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit

class Utilities{
    static let sharedInstance = Utilities()
    func createVerticleGradient(color1: UIColor, color2: UIColor, frame: CGRect) -> UIImage{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        return gradientLayer.toImage()
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        //Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension UITabBar {
    override open var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
}
extension CAGradientLayer {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        self.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage ?? UIImage()
    }
}
extension UIButton{
    func setDesignToNavigationButton(){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.30).cgColor
    }
}
extension UILabel{
    func setOrbLabelStyling(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
extension UIView{
    func animateOrbView(duration: Double){
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = duration
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    func setOrbStyle(color: UIColor){
        self.backgroundColor = .clear
        if color != .white{
            let path = UIBezierPath(ovalIn: self.bounds)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 2
            shapeLayer.shadowOpacity = 0.5
            shapeLayer.shadowColor = color.cgColor
            shapeLayer.shadowOffset = .zero
            shapeLayer.shadowRadius = 15
            shapeLayer.shadowPath = path.cgPath.copy(strokingWithWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 0)
            self.layer.addSublayer(shapeLayer)
        }else{
            self.layer.opacity = 0.20
            self.layer.cornerRadius = self.frame.size.width/2
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 2.0
        }
    }
    func addLeftRightFade(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = [0.0,0.3,0.7,1.0]
        self.layer.mask = gradient
    }
}
