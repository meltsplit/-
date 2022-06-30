//
//  Constant.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/28.
//

import Foundation
import UIKit
enum Speed : UInt32{
    case VerySlow = 10000
    case Slow = 8000
    case Normal = 6000
    case Fast = 4000
    case VeryFast = 2000
}

enum Direction {
    case Left
    case Right
}

enum SwipeDir{
    case SwipeUp
    case SwipeDown
    case SwipeLeft
    case SwipeRight
}

enum GameOver : Error {
    case roadKill
}


class Second{
    static func sec(_ sec : Int) -> UInt32{
        return UInt32(sec*1000000)
    }
}



