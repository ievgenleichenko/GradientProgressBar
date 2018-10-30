//
//  ProgressBarPoint.swift
//  GradientProgressBar
//
//  Created by Evgeniy Leychenko on 10/30/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import Foundation
import UIKit

struct ProgressBarPoint {
    
    var step: ProgressStep
    var rect: CGRect
    
    init(step: ProgressStep, rect: CGRect = .zero) {
        self.step = step
        self.rect = rect
    }
}
