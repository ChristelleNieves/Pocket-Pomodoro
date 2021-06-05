//
//  CircularProgressBarView.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 5/31/21.
//

import UIKit

class CircularProgressBarView: UIView {
    
    var progressPathColor = UIColor.systemGreen.cgColor
    var progressLayer = CAShapeLayer()
    private var circleLayer = CAShapeLayer()
    private var endPoint = CGFloat(-Double.pi / 2)
    private var startPoint = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createCircularPath() {
        
        // Create the circular path
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 163, startAngle: startPoint, endAngle: endPoint, clockwise: false)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeEnd = 1.0
        circleLayer.lineWidth = 12.0
        circleLayer.lineCap = .square
        circleLayer.shouldRasterize = true
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = progressPathColor
        circleLayer.rasterizationScale = 3.0 * UIScreen.main.scale
        
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeEnd = 0
        progressLayer.lineWidth = 12.0
        progressLayer.lineCap = .square
        progressLayer.shouldRasterize = true
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemGray6.cgColor
        progressLayer.rasterizationScale = 2.0 * UIScreen.main.scale
        
        layer.rasterizationScale = 2.0 * UIScreen.main.scale
        layer.shouldRasterize = true
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        
        // Create the circular animation using the keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .backwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func pauseAnimation(layer: CAShapeLayer) {
        let pauseTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pauseTime
    }
    
    func resumeAnimation(layer: CAShapeLayer) {
        let pauseTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        layer.beginTime = timeSincePause
    }
}
