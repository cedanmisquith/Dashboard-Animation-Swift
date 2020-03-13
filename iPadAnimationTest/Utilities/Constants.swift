//
//  Constants.swift
//  iPadAnimationTest
//
//  Created by Cedan Misquith on 14/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit

class Constants{
    static let sharedInsance = Constants()
    let DEFAULT_THEME_COLOR01 = Utilities.sharedInstance.hexStringToUIColor(hex: "#011285")
    let DEFAULT_THEME_COLOR02 = Utilities.sharedInstance.hexStringToUIColor(hex: "#1D319C")
    let CHANGED_THEME_COLOR01 = Utilities.sharedInstance.hexStringToUIColor(hex: "#0D0048")
    let CHANGED_THEME_COLOR02 = Utilities.sharedInstance.hexStringToUIColor(hex: "#4D147B")
}
