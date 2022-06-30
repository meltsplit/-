//
//  Road.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import UIKit
class Road{
    let vehicles : [Vehicle]
    let y : CGFloat
    
    init(_ v : [Vehicle], y : CGFloat){
        self.vehicles = v
        self.y = y
        
        for vehicle in vehicles{
            vehicle.body.frame.origin.y = y
        }
    }
}
extension Road{
    static var road1 = Road(Vehicle.vehicles1, y: 720)
    static var road2 = Road(Vehicle.vehicles2, y: 600)
    static var road3 = Road(Vehicle.vehicles3, y: 560)
    static var road4 = Road(Vehicle.vehicles4, y: 400)
    static var road5 = Road(Vehicle.vehicles5, y: 360)
    static var road6 = Road(Vehicle.vehicles6, y: 200)
}
