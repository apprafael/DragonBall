//
//  DragonBall.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import SwiftUI

struct DragonBallView: View {
    @State private var value = 1.0
    var body: some View {
        Circle()
            .fill(
                RadialGradient(gradient: Gradient(colors: [Color("dragonBall"), .yellow]), center: .center, startRadius: 5, endRadius: 30)
            )
            .frame(width: 30, height: 30)
            .shadow(color: .yellow, radius: 10)
            .opacity(value)
            .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true))
            .onAppear { self.value = 0.0 }
    }
}

struct DragonBall_Previews: PreviewProvider {
    static var previews: some View {
        DragonBallView()
    }
}
