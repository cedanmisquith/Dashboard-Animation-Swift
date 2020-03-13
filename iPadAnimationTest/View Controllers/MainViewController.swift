//
//  ViewController.swift
//  iPadAnimationTest
//
//  Created by Cedan Misquith on 14/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class MainViewController: UIViewController, SwitchDelegateProtocol {
    
    //Outlets
    @IBOutlet weak var optionsBGView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var orb01: UIView!
    @IBOutlet weak var orb02: UIView!
    @IBOutlet weak var orb03: UIView!
    @IBOutlet weak var orb04: UIView!
    @IBOutlet weak var orb01Label: UILabel!
    @IBOutlet weak var orb02Label: UILabel!
    @IBOutlet weak var orb03Label: UILabel!
    @IBOutlet weak var orb04Label: UILabel!
    @IBOutlet weak var infoButton: MIBadgeButton!
    @IBOutlet weak var realtimeButton: CustomButton!
    @IBOutlet weak var applicationUsageButton: CustomButton!
    @IBOutlet weak var savingsButton: CustomButton!
    @IBOutlet weak var energyProducedButton: CustomButton!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var optimumAITextLabel: UILabel!
    @IBOutlet weak var customToggleSwitch: CustomSwitch!

    //Views created in code.
    var graphContainerView: UIView!
    var defaultBG: UIImage!
    var changedBG: UIImage!

    //Variables
    var kWhValueArray = [Int]()
    var selectedOption: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting custom switch delegate.
        customToggleSwitch.switchDelegate = self
        
        setUpUI() //Function to set up UI.
        setLabelText() //Function to set up labels of all orbs.
        generatekWhValues() //Function to generate orb values.
        isSwitch(on: false) //Setting default switch state.
        badgeStyling() //Function to set up styling for info button badge.
        
        //Timer to change orb values.
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerDone), userInfo: nil, repeats: true)
        //Timer to animate graph bars.
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    
    //MARK: ---------->Function: Set up UI.
    func setUpUI(){
        //Setting up the UI.
        leftArrowButton.setDesignToNavigationButton()
        rightArrowButton.setDesignToNavigationButton()
        
        optionsBGView.layer.cornerRadius = 28.5
        
        //Creating a container for the graph animation.
        graphContainerView = UIView(frame: CGRect(x: 84, y: self.view.frame.height-210.5, width: self.view.frame.width-168, height: 160.5))
        graphContainerView.addLeftRightFade()
        graphContainerView.backgroundColor = .clear
        self.view.addSubview(graphContainerView)
        
        //Creating graph bars to animate later.
        createBars(count: Int(graphContainerView.frame.width/12))

        //Setting the Background image theme.
        changedBG = Utilities.sharedInstance.createVerticleGradient(color1: Constants.sharedInsance.CHANGED_THEME_COLOR01, color2: Constants.sharedInsance.CHANGED_THEME_COLOR02, frame: self.view.bounds)
        defaultBG = Utilities.sharedInstance.createVerticleGradient(color1: Constants.sharedInsance.DEFAULT_THEME_COLOR01, color2: Constants.sharedInsance.DEFAULT_THEME_COLOR02, frame: self.view.bounds)
        
        //Setting styles to each orb.
        orb01.setOrbStyle(color: Utilities.sharedInstance.hexStringToUIColor(hex: "#19EBFF"))
        orb02.setOrbStyle(color: .white)
        orb03.setOrbStyle(color: .white)
        orb04.setOrbStyle(color:  Utilities.sharedInstance.hexStringToUIColor(hex: "#FFCF4F "))
        
        //Setting style to each orb label.
        orb01Label.setOrbLabelStyling()
        orb02Label.setOrbLabelStyling()
        orb03Label.setOrbLabelStyling()
        orb04Label.setOrbLabelStyling()
        
        //Setting current selected option.
        updateOptionsButtonStatus(currentSelected: selectedOption)
    }
    
    //MARK: ---------->Switch Action: Switch Toggled
    func isSwitch(on: Bool) {
        //Handling Optimization switch modes.
        if on{
            self.view.backgroundColor = Constants.sharedInsance.CHANGED_THEME_COLOR01
            bgImageView.image = changedBG
        }else{
            self.view.backgroundColor = Constants.sharedInsance.DEFAULT_THEME_COLOR01
            bgImageView.image = defaultBG
        }
    }

    //MARK: ---------->Button Action: Arrow Button
    @IBAction func aarowButtonAction(_ sender: UIButton) {
        //Handling navigation arrow button taps.
        switch sender.tag{
        case 0:
            if selectedOption > 0{
                selectedOption -= 1
                updateOptionsButtonStatus(currentSelected: selectedOption)
            }
        default:
            if selectedOption < 3{
                selectedOption += 1
                updateOptionsButtonStatus(currentSelected: selectedOption)
            }
        }
    }
    
    //MARK: ---------->Function: Info button badge styling
    func badgeStyling(){
        //Setting value for info button badge.
        infoButton.badgeString = "3"
        infoButton.badgeBackgroundColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#EC1ACC")
    }
    
    @objc func animate(){
        Animation()
    }

    //MARK: ---------->Function: Create graph bars
    func createBars(count: Int){
        //Creating the bar graph views.
        var xFloat: CGFloat = 6
        for _ in 1...count{
            if xFloat < graphContainerView.frame.width-6{
                let barView = UIView(frame: CGRect(x: xFloat, y: 100, width: 6, height: graphContainerView.frame.height))
                barView.backgroundColor = .white
                barView.alpha = 0.30
                self.graphContainerView.addSubview(barView)
                xFloat += 12
            }
        }
        Animation()
    }
    
    //MARK: ---------->Function: Animating Graph Bars.
    func Animation(){
        //Creating an array of random index's to animate bar height.
        let randomIndexArray: [Int] = [
            Int.random(in: 0 ..< self.graphContainerView.subviews.count),
            Int.random(in: 0 ..< self.graphContainerView.subviews.count),
            Int.random(in: 0 ..< self.graphContainerView.subviews.count),
            Int.random(in: 0 ..< self.graphContainerView.subviews.count),
            Int.random(in: 0 ..< self.graphContainerView.subviews.count),
            Int.random(in: 0 ..< self.graphContainerView.subviews.count)
        ]
        //Random height to animate each random index from array.
        let randomHeight = Int.random(in: 100 ..< 161)
        for index in randomIndexArray{
            UIView.animate(withDuration: 0.5, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
                self.graphContainerView.subviews[index].center.y = CGFloat(randomHeight)
            }, completion:{ (finish) in
                UIView.animate(withDuration: 0.5, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
                    self.graphContainerView.subviews[index].center.y = (self.graphContainerView.frame.height+161) - CGFloat(randomHeight)
                })
            })
        }
    }
    
    
    //MARK: ---------->Function: Update Option Button Status
    func updateOptionsButtonStatus(currentSelected: Int){
        switch currentSelected{
        case 0:
            //Real Time Button
            selectedOption = 0
            realtimeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            realtimeButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
            realtimeButton.addBottomBorderWithColor(color: Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF"), width: 1)
            applicationUsageButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            applicationUsageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            applicationUsageButton.removeBorder()
            savingsButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            savingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            savingsButton.removeBorder()
            energyProducedButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            energyProducedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            energyProducedButton.removeBorder()
        case 1:
            //Application Usage Button
            selectedOption = 1
            realtimeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            realtimeButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            realtimeButton.removeBorder()
            applicationUsageButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
            applicationUsageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            applicationUsageButton.addBottomBorderWithColor(color: Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF"), width: 1)
            savingsButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            savingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            savingsButton.removeBorder()
            energyProducedButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            energyProducedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            energyProducedButton.removeBorder()
        case 2:
            //Savings Button
            selectedOption = 2
            realtimeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            realtimeButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            realtimeButton.removeBorder()
            applicationUsageButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            applicationUsageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            applicationUsageButton.removeBorder()
            savingsButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
            savingsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            savingsButton.addBottomBorderWithColor(color: Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF"), width: 1)
            energyProducedButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            energyProducedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            energyProducedButton.removeBorder()
        default:
            //Energy Produced/ Consumed Button
            selectedOption = 3
            realtimeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            realtimeButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            realtimeButton.removeBorder()
            applicationUsageButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            applicationUsageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            applicationUsageButton.removeBorder()
            savingsButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
            savingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            savingsButton.removeBorder()
            energyProducedButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
            energyProducedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            energyProducedButton.addBottomBorderWithColor(color: Utilities.sharedInstance.hexStringToUIColor(hex: "#0ADFEF"), width: 1)
        }
    }
    
    //MARK: ---------->Button Action: Info Button
    @IBAction func infoButtonAction(_ sender: Any) {
        if let badgeValue = infoButton.badgeString{
            if let badgeValueInt = Int(badgeValue){
                var temp = badgeValueInt
                temp += 1
                infoButton.badgeString = "\(temp)"
            }
        }
    }
    
    //MARK: ---------->Button Action: Options Button
    @IBAction func optionsButtonAction(_ sender: UIButton) {
        if selectedOption != sender.tag{
            updateOptionsButtonStatus(currentSelected: sender.tag)
        }
    }
    
    //MARK: ---------->FUNCTION: Set label text
    func setLabelText(){
        orb02Label.text = "Super\nEconomy"
        let font:UIFont? = UIFont.boldSystemFont(ofSize: 30)
        let fontSuper:UIFont? = UIFont.systemFont(ofSize: 10)
        let attributedString01:NSMutableAttributedString = NSMutableAttributedString(string: "3rd", attributes: [.font:font!])
        attributedString01.setAttributes([.font:fontSuper!,.baselineOffset:15], range: NSRange(location:1,length:2))
        let mainString = "Rank\nAmong 10 \nneighbours"
        let attributedString02 = NSMutableAttributedString(string: mainString, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        let combination = NSMutableAttributedString()
        combination.append(attributedString01)
        combination.append(attributedString02)
        orb03Label.attributedText = combination

        let font2:UIFont? = UIFont.boldSystemFont(ofSize: 30)
        let fontSuper2:UIFont? = UIFont.systemFont(ofSize: 20)
        let attributedString03:NSMutableAttributedString = NSMutableAttributedString(string: "$356", attributes: [.font:font2!])
        attributedString03.setAttributes([.font:fontSuper2!,.baselineOffset:-10], range: NSRange(location:0,length:1))
        orb04Label.attributedText = attributedString03
    }
    
    //MARK: ---------->FUNCTION: Generate kWh Values
    func generatekWhValues(){
        for i in 820..<851 {
            kWhValueArray.append(i)
        }
    }
    
    
    //MARK: ---------->FUNCTION: Timer Done
    @objc func timerDone(){
        let randomValue = kWhValueArray.randomElement()!
        let longString = "\(randomValue) kWh\n28 Devices"
        let longestWord = "\(randomValue)"
        let longestWordRange = (longString as NSString).range(of: longestWord)
        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor : UIColor.white], range: longestWordRange)
        orb01Label.attributedText = attributedString
        orb01.animateOrbView(duration: 1)
        if 820 ... 830 ~= randomValue {
            if let shapeLayer = orb01.layer.sublayers?[0] as? CAShapeLayer{
                shapeLayer.strokeColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#19EBFF").cgColor
                shapeLayer.shadowColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#19EBFF").cgColor
            }
        }else if 831 ... 840 ~= randomValue{
            if let shapeLayer = orb01.layer.sublayers?[0] as? CAShapeLayer{
                shapeLayer.strokeColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#FFCF4F").cgColor
                shapeLayer.shadowColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#FFCF4F").cgColor
            }
        }else if 841 ... 850 ~= randomValue{
            if let shapeLayer = orb01.layer.sublayers?[0] as? CAShapeLayer{
                shapeLayer.strokeColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#FF3D00").cgColor
                shapeLayer.shadowColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#FF3D00").cgColor
            }
        }
        orb04.animateOrbView(duration: 1)
    }
}

