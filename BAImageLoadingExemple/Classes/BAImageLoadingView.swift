//
//  BAImageLoadingView.swift
//  BAImageLoadingExemple
//
//  Created by Benjamin Deneux on 16/07/2015.
//  Copyright (c) 2015 Bananapp's. All rights reserved.
//

import UIKit

class BAImageLoadingView: UIImageView {
    
    
    /**
     * Set the opacity of the background mask
     */
    var maskOpacity: CGFloat = 0.7
    
    /**
     * Set the color of the progress bar
     */
    var progressColor: UIColor = UIColor(red: 190/255, green: 219/255, blue: 57/255, alpha: 1)
    
    /**
     * Set the width of the progress bar
     */
    var progressWidth: CGFloat = 10.0
    
    var startAngle = CGFloat(3*M_PI_2)
    var endAngle = CGFloat((3*M_PI) + (M_PI_2))
    // Radius in percent
    var radius: CGFloat = 50
    
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    private let maskLayer: CAShapeLayer = CAShapeLayer()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initProgressLayer()
        startLoading()
    }
    
    private func initProgressLayer() {
        let rayon: CGFloat = CGRectGetHeight(frame)/2
        
        let centerPoint = CGPointMake(rayon , rayon)
        var finalRadius = (rayon*radius)/100
        
        progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: finalRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = progressColor.CGColor
        progressLayer.lineWidth = progressWidth
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1.0
        
        layer.addSublayer(progressLayer)
        
        
        maskLayer.path = UIBezierPath(rect: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))).CGPath
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: maskOpacity).CGColor
        
        
        
        layer.insertSublayer(maskLayer, below: progressLayer)
    }
    
    func startLoading() {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.5
        animationGroup.repeatCount = Float.infinity
        
        let animationEnd = CABasicAnimation(keyPath: "strokeEnd")
        animationEnd.fromValue = 0.0
        animationEnd.toValue = 1.0
        animationEnd.duration = 1.0
        animationEnd.fillMode = kCAFillModeForwards
        animationEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        
        let animationStart = CABasicAnimation(keyPath: "strokeStart")
        animationStart.fromValue = 0.0
        animationStart.toValue = 1.0
        animationStart.duration = 1.5
        //animationStart.beginTime = 2.0
        animationStart.fillMode = kCAFillModeForwards
        animationStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        animationGroup.animations = [animationEnd, animationStart]
        
        //progressLayer.strokeEnd = CGFloat(1)
        progressLayer.addAnimation(animationGroup, forKey: "animations")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
