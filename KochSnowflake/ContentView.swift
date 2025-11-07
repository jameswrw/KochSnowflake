//
//  ContentView.swift
//  KochSnowflake
//
//  Created by James Weatherley on 06/11/2025.
//

import SwiftUI

struct ContentView: View {
    let triangleHeight = sqrt(3.0) / 2.0
    // Push the drawing down to avoid clipping at the top.
    // Tune this fraction to taste; 0.06–0.12 works nicely depending on line width.
    let verticalInsetFraction: CGFloat = 0.08

    @State private var maxGeneration: Double = 0.0
    @State private var useTriangleSeed: Bool = true

    private func triangleSeed(for size: CGSize) -> [Line] {
        let yInset = size.height * verticalInsetFraction
        return [
            Line(
                start: CGPoint(x: 0.0, y: size.height / 4.0 + yInset),
                end: CGPoint(x: size.width, y: size.height / 4.0 + yInset)
            ),
            Line(
                start: CGPoint(x: size.width, y: size.height / 4.0 + yInset),
                end: CGPoint(x: size.width / 2.0, y: size.height * triangleHeight + yInset)
            ),
            Line(
                start: CGPoint(x: size.width / 2.0, y: size.height * triangleHeight + yInset),
                end: CGPoint(x: 0.0, y: size.height / 4.0 + yInset)
            )
        ]
    }

    private func singleEdgeSeed(for size: CGSize) -> [Line] {
        let yInset = size.height * verticalInsetFraction
        return [
            Line(
                start: CGPoint(x: size.width * 0.1, y: size.height * 0.5 + yInset),
                end: CGPoint(x: size.width * 0.9, y: size.height * 0.5 + yInset)
            )
        ]
    }

    private func makeModel(for size: CGSize) -> KochSnowflakeModel {
        let seed = useTriangleSeed ? triangleSeed(for: size) : singleEdgeSeed(for: size)
        return KochSnowflakeModel(
            maxGeneration: UInt(maxGeneration),
            initialVertices: seed
        )
    }

    var body: some View {
        VStack(spacing: 20) {
            // Controls
            VStack(spacing: 8) {
                HStack {
                    Text("Generation: \(Int(maxGeneration))")
                    Spacer()
                    Stepper("", value: $maxGeneration, in: 0...6, step: 1)
                        .labelsHidden()
                }
                Slider(value: $maxGeneration, in: 0...6, step: 1)

                Toggle("Triangle seed", isOn: $useTriangleSeed)
                    .toggleStyle(.switch)
            }

            // Drawing area
            GeometryReader { proxy in
                let model = makeModel(for: proxy.size)
                KochSnowflakeShape(model: model)
                    .stroke(.black, lineWidth: 1)
                    .drawingGroup()
                    .contentShape(Rectangle())
                    .animation(.easeInOut(duration: 0.25), value: maxGeneration)
            }
            .aspectRatio(1, contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ContentView()
}
