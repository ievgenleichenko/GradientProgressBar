//
//  CGContext+Drawing.swift
//  GradientProgressBar
//
//  Created by Evgeniy Leychenko on 10/30/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGContext {
    
    func add(point: ProgressBarPoint) {
        addEllipse(in: point.rect)
    }
    
    func addLine(ofSize lineSize: CGSize, after point: ProgressBarPoint, withOverlapping overlapping: CGFloat) {
        let lineRect = CGRect(origin: CGPoint(x: point.rect.maxX - overlapping,
                                              y: point.rect.size.height / 2 - lineSize.height / 2),
                              size: lineSize)
        addRect(lineRect)
    }
    
    func highlight(point: ProgressBarPoint) {
        setFillColor(point.step.color.cgColor)
        fillEllipse(in: point.rect)
    }
    
    func drawRadialGradient(withRadius radius: CGFloat, between startPoint: ProgressBarPoint, and endPoint: ProgressBarPoint) {
        let colors = [startPoint.step.color.cgColor,
                      endPoint.step.color.cgColor] as CFArray
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: nil) else { return }
        
        let start = CGPoint(x: startPoint.rect.maxX,
                            y: startPoint.rect.minY + endPoint.rect.size.height / 2)
        let end = CGPoint(x: endPoint.rect.minX,
                          y: start.y)
        drawRadialGradient(gradient, startCenter: start, startRadius: radius, endCenter: end, endRadius: radius, options: [])
    }
}
