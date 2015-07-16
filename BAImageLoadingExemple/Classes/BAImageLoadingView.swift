//
//  BAImageLoadingView.swift
//  BAImageLoadingExemple
//
//  Created by Benjamin Deneux on 16/07/2015.
//  Copyright (c) 2015 Bananapp's. All rights reserved.
//

import UIKit

@IBDesignable
class BAImageLoadingView: UIImageView {
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    private let maskLayer: CAShapeLayer = CAShapeLayer()
    
    
    /**
    * Set the corner radius of the UIImage
    */
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    /**
     * Set the opacity of the background mask
     */
    @IBInspectable var maskOpacity: CGFloat = 0.7 {
        didSet {
            setupView()
        }
    }
    
    /**
     * Set the color of the progress bar
     */
    @IBInspectable var progressColor: UIColor = UIColor(red: 190/255, green: 219/255, blue: 57/255, alpha: 1) {
        didSet {
            setupView()
        }
    }
    
    /**
     * Set the width of the progress bar
     */
    @IBInspectable var progressWidth: CGFloat = 10.0 {
        didSet {
            setupView()
        }
    }
    
    /**
     * Setup the distance between the progress bar and the border
     */
    @IBInspectable var radius: CGFloat = 50 {
        didSet {
            setupView()
        }
    }
    
    var startAngle = CGFloat(3*M_PI_2)
    var endAngle = CGFloat((3*M_PI) + (M_PI_2))
    

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        startLoading()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        //startLoading()
    }
    
    private func setupView() {
        let rayon: CGFloat = CGRectGetHeight(frame)/2
        
        // Set the center point of the progress bar
        let centerPoint = CGPointMake(rayon , rayon)
        
        // Get the final radius for the progress bar with radius percent
        let finalRadius = (rayon*radius)/100
        
        // ************
        // Create the progress bar layer
        // ************
        progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: finalRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = progressColor.CGColor
        progressLayer.lineWidth = progressWidth
        progressLayer.strokeStart = 0.0
#if !TARGET_INTERFACE_BUILDER
        progressLayer.strokeEnd = 0.0
#else
        progressLayer.strokeEnd = 0.5
#endif
        
        layer.addSublayer(progressLayer)
        
        
        // ************
        // Create the mask layer
        // ************
        maskLayer.path = UIBezierPath(rect: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))).CGPath
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: maskOpacity).CGColor
        
        layer.insertSublayer(maskLayer, below: progressLayer)
    }
    
    
    
    
    /**
     * Start the loading animation on the UIImageView
     */
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
    
    func stopLoading() {
        progressLayer.removeAllAnimations()
        
        progressLayer.removeFromSuperlayer()
        maskLayer.removeFromSuperlayer()
    }
    
    func setLoadedImage(image: UIImage) {
        stopLoading()
        
        self.image = image
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    

}
