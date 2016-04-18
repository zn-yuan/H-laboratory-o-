//
//  ShapeLayer.swift
//  laboratory
//
//  Created by hryan on 16/2/19.
//  Copyright © 2016年 fe. All rights reserved.
//

import UIKit

class ShapeLayerViewController: UIViewController {
    
    override func viewDidLoad() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "dismiss", style: .Plain, target: self, action: #selector(ShapeLayerViewController.dismiss))
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.drawBezierPath1()
        self.drawBezierPath3()
        self.drawBezierPath4()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func drawBezierPath1() {
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRectMake(110, 100, 150, 100), cornerRadius: 0)
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.lightGrayColor().CGColor
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    func drawBezierPath2() {
        let radius: CGFloat = 60.0
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = CGFloat(M_PI)
        
        let path = UIBezierPath(arcCenter: self.view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.redColor().CGColor
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func drawBezierPath3() {
        let startPoint = CGPointMake(50, 300)
        let endPoint = CGPointMake(300, 300)
        let controlPoint = CGPointMake(170, 200)
        let controlPoint2 = CGPointMake(220, 350)
        
        let layer1 = CALayer()
        layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5)
        layer1.backgroundColor = UIColor.redColor().CGColor
        
        let layer2 = CALayer()
        layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5)
        layer2.backgroundColor = UIColor.redColor().CGColor
        
        let layer3 = CALayer()
        layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5)
        layer3.backgroundColor = UIColor.redColor().CGColor
        
        let layer4 = CALayer()
        layer4.frame = CGRectMake(controlPoint2.x, controlPoint2.y, 5, 5)
        layer4.backgroundColor = UIColor.redColor().CGColor
        
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.moveToPoint(startPoint)
        path.addCurveToPoint(endPoint, controlPoint1: controlPoint, controlPoint2: controlPoint2)
        
        layer.path = path.CGPath
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = UIColor.blackColor().CGColor
        
        view.layer.addSublayer(layer)
        view.layer.addSublayer(layer1)
        view.layer.addSublayer(layer2)
        view.layer.addSublayer(layer3)
        view.layer.addSublayer(layer4)
        self.animation3(layer)
        
    }
    
    
    func drawBezierPath4() {
        let finalSize = CGSizeMake(CGRectGetWidth(view.frame), 500)
        let layerHeight = finalSize.height * 0.1
        let layer = CAShapeLayer()
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPointMake(0, finalSize.height - layerHeight))
        bezier.addLineToPoint(CGPointMake(0, finalSize.height - 1))
        bezier.addLineToPoint(CGPointMake(finalSize.width, finalSize.height - 1))
        bezier.addLineToPoint(CGPointMake(finalSize.width, finalSize.height - layerHeight))
        bezier.addQuadCurveToPoint(CGPointMake(0,finalSize.height - layerHeight),
            controlPoint: CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40))
        layer.path = bezier.CGPath
        layer.fillColor = UIColor.blackColor().CGColor
        view.layer.addSublayer(layer)
    }
    
    
    private func animation1(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        layer.addAnimation(animation, forKey: "")
    }
    
    private func animation2(layer: CAShapeLayer) {
        layer.strokeStart = 0.5
        layer.strokeEnd = 0.5
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0.5
        animation.toValue = 0
        animation.duration = 2
        
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = 0.5
        animation2.toValue = 1
        animation2.duration = 2
        
        layer.addAnimation(animation, forKey: "")
        layer.addAnimation(animation2, forKey: "")
    }
    
    private func animation3(layer: CAShapeLayer) {
        self.animation2(layer)
        
        let animation = CABasicAnimation(keyPath: "lineWidth")
        animation.fromValue = 1
        animation.toValue = 10
        animation.duration = 2
        layer.addAnimation(animation, forKey: "")
    }

    
    
}
