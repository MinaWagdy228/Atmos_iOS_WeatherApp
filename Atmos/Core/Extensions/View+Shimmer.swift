//
//  View+Shimmer.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var isAnimating = false
    let highlightColor: Color

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    // 2. Use the dynamic color instead of hardcoded .white
                    gradient: Gradient(colors: [.clear, highlightColor, .clear]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(20))
                .offset(x: isAnimating ? 400 : -400)
            )
            .mask(content)
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5).repeatForever(autoreverses: false)
                ) {
                    isAnimating = true
                }
            }
    }
}

extension View {
    @ViewBuilder
    func shimmer(isActive: Bool = true, color: Color = .white.opacity(0.4))
        -> some View
    {
        if isActive {
            self.modifier(ShimmerEffect(highlightColor: color))
        } else {
            self
        }
    }
}
