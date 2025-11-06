//
//  KochSnowflakeShape.swift
//  KochSnowflakeShape
//
//  Created by James Weatherley on 06/11/2025.
//

import SwiftUI

struct KochSnowflakeShape: Shape {
    
    var model: KochSnowflakeModel
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for vertex in model.vertices {
            path.move(to: vertex.start)
            path.addLine(to: vertex.end)
        }
        
        return path
    }
}

//#Preview {
//    KochSnowflakeView()
//}
