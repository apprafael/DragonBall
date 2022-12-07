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
            .fill(Color("dragonBall"))
            .frame(width: 30, height: 30)
            .shadow(color: .orange, radius: 10)
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
