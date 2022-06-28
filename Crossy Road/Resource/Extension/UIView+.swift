//
//  UIView+.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import Foundation
import UIKit
extension UIView{
    
    func addSubviews(_ map: Map) {
        map.wholeCars().forEach {self.addSubview($0.body)}
    }
    
    func addSubviews(_ road: Road) {
        road.vehicles.forEach { self.addSubview($0.body) }
    }
}
