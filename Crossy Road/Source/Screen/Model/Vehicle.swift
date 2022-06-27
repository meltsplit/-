//
//  Car.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit
protocol moveProtocol{
    func move(_ direction : Direction)
    //func moveLeft()
}
class Vehicle : moveProtocol{
    var body = UIView()
    let y : CGFloat
    let color : UIColor
    let speed : Speed
    
    init(y : CGFloat,color : UIColor,speed : Speed){
        self.y = y
        self.speed = speed
        self.color = color
        
        self.body.frame.origin = CGPoint(x: -10000, y: y)
        self.body.backgroundColor = color
    }
    
    func move(_ direction : Direction ) {
        var x : CGFloat = (direction == Direction.Left) ? -200 : 414
        DispatchQueue.global().async {
            while (true){
                x = (direction == Direction.Left) ? x + 1 : x - 1
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
    }
}

class Bus : Vehicle{
    override init(y: CGFloat, color: UIColor, speed: Speed) {
        super.init(y: y, color: color, speed: speed)
        body.frame.size = CGSize(width: 80, height: 40)
    }
}
