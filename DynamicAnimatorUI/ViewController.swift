//
//  ViewController.swift
//  DynamicAnimatorUI
//
//  Created by 片桐奏羽 on 2015/09/09.
//  Copyright (c) 2015年 SoKatagiri. All rights reserved.
//

import UIKit

extension UIColor{
    class func randomColor ()->(UIColor) {
        let colors = [
            UIColor.redColor(),
            UIColor.greenColor(),
            UIColor.blackColor(),
            UIColor.purpleColor(),
            UIColor.blueColor(),
            UIColor.yellowColor()
        ]
        let r = arc4random_uniform(UInt32(colors.count))
        return colors[Int(r)]
    }
}

class ViewController: UIViewController {
    
    var dynamiAnimator:UIDynamicAnimator?
    var gravityBehavior:UIGravityBehavior?
    var collisionBehavior:UICollisionBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // UIDynamicAnimator is iOS7-

        // make target view

        let v = self.getView(CGRect(x: 0, y: 0, width: 100, height: 100))
        v.center = CGPoint(x: 150,y: 150)
        
        self.view.addSubview(v)
        
        self.dynamiAnimator = UIDynamicAnimator(referenceView:self.view)
        
        // collision
        self.collisionBehavior = UICollisionBehavior(items: [v])
        self.collisionBehavior?.translatesReferenceBoundsIntoBoundary = true
        
        // gravity
        self.gravityBehavior = UIGravityBehavior(items: [v])
        self.gravityBehavior?.gravityDirection = CGVectorMake(0.0, 1.0)
        
        // set behavior
        self.dynamiAnimator?.addBehavior(self.collisionBehavior)
        self.dynamiAnimator?.addBehavior(self.gravityBehavior)
        
    }
    

    
    func getView(frame:CGRect)->(UIView){
        let v:UIView = UIView(frame: frame)
        v.backgroundColor = UIColor.randomColor()
        return v
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let point = touch.locationInView(self.view)
        
        let height = Int(arc4random_uniform(100)+1)
        let width = Int(arc4random_uniform(100)+1)
        let rot =  CGFloat(2 * M_PI * Double(arc4random_uniform(360))/360.0)
        
        let v = self.getView(CGRect(x:0, y:0, width: width, height: height))
        v.center = point
        self.view .addSubview(v)
        v.transform = CGAffineTransformMakeRotation(rot)

        self.collisionBehavior?.addItem(v)
        self.gravityBehavior?.addItem(v)
        
        
        
    }

}

