//
//  Home.swift
//  MetaBall
//
//  Created by 山本響 on 2022/09/25.
//

import SwiftUI

struct Home: View {
    // MARK: Animation Properties
    @State var dragOffset: CGSize = .zero
    var body: some View {
        // MARK: Single MetaBall Animation
        VStack {
            SingleMetaBall()
        }
        
    }
    
    @ViewBuilder
    func SingleMetaBall() -> some View {

        Canvas { context, size in
            // MARK: Adding Filters
            context.addFilter(.alphaThreshold(min: 0.5, color: .red))
            // MARK: This blur Rarius determines the amount of elasticity between two elements
            context.addFilter(.blur(radius: 30))
            
            // MARK: Drawing Layer
            context.drawLayer { ctx in
                // MARK: Placing Symbois
                for index in [1,2] {
                    if let resolvedView = context.resolveSymbol(id: index) {
                        ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            Ball()
                .tag(1)
            
            Ball(offset: dragOffset)
                .tag(2)
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    dragOffset = value.translation
                }).onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragOffset = .zero
                    }
                })
        )
    }
    
    @ViewBuilder
    func Ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
