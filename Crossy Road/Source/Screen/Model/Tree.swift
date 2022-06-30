//
//  Tree.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/07/01.
//

import Foundation
import UIKit
class Tree{
    let body = UIView()
    let axis : CGPoint
    init (axis : CGPoint){
        body.frame.size = CGSize(width: 40, height: 40)
        body.frame.origin = axis
        body.backgroundColor = .green
        self.axis = axis
    }
}
extension Tree{
    static var trees : [Tree] = [
        Tree(axis: CGPoint(x: 80, y: 240)),
        Tree(axis: CGPoint(x: 200, y: 440)),
        Tree(axis: CGPoint(x: 80, y: 680))
    ]
}
