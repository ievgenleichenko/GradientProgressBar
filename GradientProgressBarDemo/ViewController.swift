//
//  ViewController.swift
//  GradientProgressBarDemo
//
//  Created by Evgeniy Leychenko on 10/29/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var progressBar: GradientProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let steps = [ProgressStep(color: .green, name: "Start", isActive: false),
                     ProgressStep(color: .blue, name: "Middle", isActive: false),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    // MARK: - Actions -
    
    @IBAction private func inactiveAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: false),
                     ProgressStep(color: .blue, name: "Middle", isActive: false),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    @IBAction private func activeAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: true),
                     ProgressStep(color: .red, name: "End", isActive: true)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    @IBAction private func activateFirstAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: false),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    @IBAction private func activateSecondAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: true),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    @IBAction private func fiveStepsAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .orange, name: "Extra", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: true),
                     ProgressStep(color: .yellow, name: "Extra", isActive: true),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    @IBAction private func largerStepsAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: true),
                     ProgressStep(color: .red, name: "End", isActive: false)]
        progressBar.set(steps: steps)
        progressBar.stepIndicatorRadius = 15
        progressBar.progressLineHeight = 5
    }
    
    @IBAction private func removeTextAction(_ sender: UIButton) {
        let steps = [ProgressStep(color: .green, name: "Start", isActive: true),
                     ProgressStep(color: .blue, name: "Middle", isActive: true),
                     ProgressStep(color: .red, name: "", isActive: true)]
        progressBar.set(steps: steps)
        normalize()
    }
    
    // MARK: - Private -
    
    private func normalize() {
        progressBar.stepIndicatorRadius = 5
        progressBar.progressLineHeight = 2
    }
}
