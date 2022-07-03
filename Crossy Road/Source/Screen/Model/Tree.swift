//
//  Tree.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/07/01.
//

import Foundation
import UIKit
class Tree{
    let body = UIImageView()
    let axis : CGPoint
    
    init (axis : CGPoint){
        body.image = UIImage(named: Image.tree)
        body.frame.size = CGSize(width: 40, height: 40)
        body.frame.origin = axis
        self.axis = axis
    }
}
extension Tree{
    static var trees : [Tree] = [
        Tree(axis: CGPoint(x: 80, y: 160)),
        Tree(axis: CGPoint(x: 200, y: 480)),
        Tree(axis: CGPoint(x: 320, y: 680)),
        Rock(axis: CGPoint(x: 400, y: 160)),
        Rock(axis: CGPoint(x: 100, y: 320)),
        Rock(axis: CGPoint(x: 320, y: 320)),
        Rock(axis: CGPoint(x: 120, y: 480)),
        Rock(axis: CGPoint(x: 160, y: 680)),
    ]
}

class Rock : Tree{
    override init(axis: CGPoint) {
        super.init(axis: axis)
        body.image = UIImage(named: Image.rock)
    }
}

class Chicken {
    let body = UIImageView()
    let axis : CGPoint
    
    init (axis : CGPoint){
        body.image = UIImage(named: Image.chicken)
        body.frame.size = CGSize(width: 40, height: 40)
        body.frame.origin = axis
        self.axis = axis
    }
}
