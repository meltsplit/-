//
//  Car.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

protocol movable{
    func moveRight()
    func moveLeft()
}

class Vehicle : movable{
    var body = UIView()
    let y : CGFloat
    let color : UIColor
    let speed : Speed
    var width : CGFloat?
    
    init(y : CGFloat,color : UIColor,speed : Speed){
        self.y = y
        self.speed = speed
        self.color = color
        
        self.body.frame.origin = CGPoint(x: -10000, y: y)
        self.body.backgroundColor = color
    }
    
    func moveRight() {
        var x : CGFloat = -self.width!
        DispatchQueue.global().async {
            while (x < 414){
                x =  x + 1
                DispatchQueue.main.async {
                    self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                }
                usleep(self.speed.rawValue)
               
            }
        }
    }
    
    func moveLeft() {
        var x : CGFloat = 414
        DispatchQueue.global().async {
            while (x > -self.width!){
                x = x - 1
                DispatchQueue.main.async {
                    self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                }
                usleep(self.speed.rawValue)
               
            }
        }
    }
    
}

class Car : Vehicle{
    override init(y: CGFloat, color: UIColor, speed: Speed) {
        super.init(y: y, color: color, speed: speed)
        body.frame.size = CGSize(width: 40, height: 40)
        width = body.frame.size.width
    }
}

class Bus : Vehicle{
    override init(y: CGFloat, color: UIColor, speed: Speed) {
        super.init(y: y, color: color, speed: speed)
        body.frame.size = CGSize(width: 80, height: 40)
        width = body.frame.size.width
    }
}
