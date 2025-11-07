//
//  KochSnowflakeTests.swift
//  KochSnowflakeTests
//
//  Created by James Weatherley on 06/11/2025.
//

import Testing
import AppKit
@testable import KochSnowflake

struct KochSnowflakeTests {

    @Test func testVertexCount() async throws {
        let size = CGSize(width: 600, height: 600)
        let triangleHeight = sqrt(3.0) / 2.0
        
        let seed = [
            Line(
                start: CGPoint(x: 0.0, y: size.height / 4.0),
                end: CGPoint(x: size.width, y: size.height / 4.0)
            ),
            Line(
                start: CGPoint(x: size.width, y: size.height / 4.0),
                end: CGPoint(x: size.width / 2.0, y: size.height * triangleHeight)
            ),
            Line(
                start: CGPoint(x: size.width / 2.0, y: size.height * triangleHeight),
                end: CGPoint(x: 0.0, y: size.height / 4.0)
            )
        ]
        
        for i in 0...6 {
            let model = await KochSnowflakeModel(maxGeneration: i, initialVertices: seed)
            #expect(model.vertices.count == Int(3 * pow(4.0, Double(i))))
        }
    }

}
