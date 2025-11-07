//
//  KochSnowflakeModel.swift
//  KochSnowflake
//
//  Created by James Weatherley on 06/11/2025.
//

import Foundation

struct Line {
    let start: CGPoint
    let end: CGPoint
}

struct KochSnowflakeModel {
    var vertices: [Line]
    private var currentGeneration: Int
    var maxGenerations: Int
    
    init(maxGeneration: Int, initialVertices: [Line]) {
        self.currentGeneration = 0
        self.maxGenerations = maxGeneration
        self.vertices = initialVertices
        
        if maxGeneration > 0 {
            generateVertices()
        }
    }
    
    private mutating func generateVertices() {
        var newVertices: [Line] = []
        for vertex in vertices {
            let deltaX = vertex.end.x - vertex.start.x
            let deltaY = vertex.end.y - vertex.start.y
            var start = vertex.start
            var end = CGPoint(
                x: vertex.start.x + deltaX / 3.0,
                y: vertex.start.y + deltaY / 3.0
            )
            
            newVertices.append(Line(start: start, end: end))
            
            start = end
            end = CGPoint(
                x: start.x + deltaX / 6.0 + deltaY / 3.0 * (sqrt(3.0) / 2.0),
                y: start.y + deltaY / 6.0 - deltaX / 3.0 * (sqrt(3.0) / 2.0)
            )
            newVertices.append(Line(start: start, end: end))
            
            start = end
            end = CGPoint(
                x: vertex.start.x + deltaX * 2.0 / 3.0,
                y: vertex.start.y + deltaY * 2.0 / 3.0
            )
            newVertices.append(Line(start: start, end: end))
            
            start = end
            end = vertex.end
            newVertices.append(Line(start: start, end: end))
        }
        
        vertices = newVertices
        currentGeneration += 1
        
        if currentGeneration == maxGenerations || currentGeneration > 6 {
            return
        } else {
            generateVertices()
        }
    }
}
