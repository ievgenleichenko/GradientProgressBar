//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Evgeniy Leychenko on 10/29/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit
import CoreGraphics

public class GradientProgressBar: UIView {
    
    // Color used to fill inactive steps of the progress bar
    @IBInspectable var emptyProgressColor: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }
    // Radius of the step indicator circle
    @IBInspectable var stepIndicatorRadius: CGFloat = 5 {
        didSet { setNeedsLayout() }
    }
    // Height of the progress line (between circles)
    @IBInspectable var progressLineHeight: CGFloat = 2 {
        didSet { setNeedsLayout() }
    }
    // Font of the label displaying current progress status
    @IBInspectable var statusLabelFont: UIFont {
        set {
            statusLabel.font = newValue
            setNeedsLayout()
        }
        get {
            return statusLabel.font
        }
    }
    
    private lazy var statusLabel = UILabel()
    private var progressPoints: [ProgressBarPoint] = []
    
    private var overlapping: CGFloat = 1 // elements should overlap by this value
    private var statusLableTopOffset: CGFloat = 5
    
    private var pointSize: CGSize { return CGSize(width: stepIndicatorRadius * 2, height: stepIndicatorRadius * 2) }
    private var progressHeight: CGFloat { return max(pointSize.height, progressLineHeight) }
    
    // MARK: - Lifecycle -
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        progressPoints = updatedPointsForDrawing(from: progressPoints)
        
        statusLabel.removeFromSuperview()
        if let lastActivePoint = progressPoints.last(where: { $0.step.isActive }),
            let pointIndex = progressPoints.lastIndex(where: { $0.rect == lastActivePoint.rect }) {
            addStatusLabel(for: lastActivePoint, at: pointIndex)
        }
        
        updateHeight()
        setNeedsDisplay()
    }

    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        clear(context: context, in: rect)
        
        guard progressPoints.count > 0 else { return }

        drawEmptyProgressBar(in: context)
        
        let activePoints = progressPoints.filter { $0.step.isActive }
        activatePoints(activePoints, in: context)
    }
    
    // MARK: - Private -
    
    private func addStatusLabel(for point: ProgressBarPoint, at index: Int) {
        statusLabel.text = point.step.name
        statusLabel.textColor = point.step.color
        statusLabel.sizeToFit()
        
        let labelYPosition = progressHeight + statusLableTopOffset
        if index == 0 {
            statusLabel.frame.origin = CGPoint(x: point.rect.minX, y: labelYPosition)
        } else if index == progressPoints.count - 1 {
            statusLabel.frame.origin = CGPoint(x: point.rect.maxX - statusLabel.frame.size.width,
                                               y: labelYPosition)
        } else {
            statusLabel.frame.origin = CGPoint(x: point.rect.origin.x + point.rect.size.width/2 - statusLabel.frame.size.width/2,
                                               y: labelYPosition)
        }
        
        addSubview(statusLabel)
    }
    
    private func updatedPointsForDrawing(from points: [ProgressBarPoint]) -> [ProgressBarPoint] {
        let interpointSpace = calculateInterpointSpace(forSteps: points.count, inTotalWidth: bounds.size.width)
        
        var startX: CGFloat = 0
        let updatedPoints = points.map { (point) -> ProgressBarPoint in
            var updatedPoint = point
            updatedPoint.rect = CGRect(origin: CGPoint(x: startX, y: 0), size: pointSize)
            
            startX += pointSize.width
            startX += interpointSpace
            
            return updatedPoint
        }
        
        return updatedPoints
    }
    
    private func calculateInterpointSpace(forSteps stepsCount: Int, inTotalWidth width: CGFloat) -> CGFloat {
        let pointsSpace = CGFloat(stepsCount) * pointSize.width
        let freeSpace = width - pointsSpace
        
        return freeSpace / CGFloat(stepsCount - 1)
    }
    
    private func updateHeight() {
        let height: CGFloat = statusLabel.superview != nil ? statusLabel.frame.maxY : progressHeight
        
        if let heightConstraint = constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = height
        } else {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func clear(context: CGContext, in rect: CGRect) {
        context.clear(rect)
        context.setFillColor(backgroundColor?.cgColor ?? UIColor.clear.cgColor)
        context.fill(rect)
    }
    
    private func drawEmptyProgressBar(in context: CGContext) {
        let interpointSpace = calculateInterpointSpace(forSteps: progressPoints.count, inTotalWidth: bounds.size.width)
        let progressLineSize = CGSize(width: interpointSpace + 2*overlapping, height: progressLineHeight)
        
        context.beginPath()
        for (index, point) in progressPoints.enumerated() {
            context.add(point: point)
            
            guard index > 0 else { continue }
            let previousPoint = progressPoints[index-1]
            context.addLine(ofSize: progressLineSize, after: previousPoint, withOverlapping: overlapping)
        }
        context.closePath()
        context.setFillColor(emptyProgressColor.cgColor)
        context.fillPath()
    }
    
    private func activatePoints(_ points: [ProgressBarPoint], in context: CGContext) {
        for (index, point) in points.enumerated() {
            context.highlight(point: point)
            
            guard index > 0 else { continue }
            let previousPoint = points[index-1]
            context.drawRadialGradient(withRadius: progressLineHeight/2, between: previousPoint, and: point)
        }
    }
}

// MARK: - Public -

public extension GradientProgressBar {
    
    public func set(steps: [ProgressStep]) {
        progressPoints = steps.map({ ProgressBarPoint(step: $0) })
        setNeedsLayout()
    }
}
