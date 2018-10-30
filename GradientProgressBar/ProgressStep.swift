//
//  ProgressStep.swift
//  GradientProgressBar
//
//  Created by Evgeniy Leychenko on 10/29/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import Foundation
import UIKit

public struct ProgressStep {
    
    private(set) var color: UIColor
    private(set) var name: String
    private(set) var isActive: Bool
    
    init(color: UIColor, name: String, isActive: Bool = false) {
        self.color = color
        self.name = name
        self.isActive = isActive
    }
}
