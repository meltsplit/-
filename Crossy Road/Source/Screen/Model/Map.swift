//
//  Map.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import Foundation

struct Map{
    var roads : [Road]
    
    func wholeCars()->[Vehicle]{
        var vehicleList : [Vehicle] = []
        for road in roads{
            for vehicle in road.vehicles{
                vehicleList.append(vehicle)
            }
        }
        return vehicleList
    }
}

extension Map{
    static var map1  = Map(roads: [
        Road.road1,
        Road.road2,
        Road.road3,
        Road.road4,
        Road.road5,
        Road.road6
    ])
}
