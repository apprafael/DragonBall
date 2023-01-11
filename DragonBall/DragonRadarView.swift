//
//  ContentView.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import SwiftUI
import AVKit

struct DragonRadarView: View {
    var interector = DragonBallRadarInteractor()
    @StateObject var viewModel = DragonRadarViewModel()
    var body: some View {
        ZStack(alignment: .center) {
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 3) {
                ForEach(0...20, id: \.self) {_ in
                    HStack(spacing: 3) {
                        ForEach(0...20, id: \.self) {_ in
                            Rectangle()
                                .fill(Color("radarbackground"))
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            UserPinView()
            
            ForEach(viewModel.dragonBalls) { dragonBall in
                DragonBallView()
                    .offset(y: CGFloat(dragonBall.distance))
                    .rotationEffect(.degrees(dragonBall.direction))
                
            }
            .rotationEffect(.degrees(viewModel.magneticHeading))
        }
        .onAppear {
            interector.viewModel = viewModel
            interector.createAndTrackingDragonBalls()
            viewModel.viewDidInit()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DragonRadarView()
    }
}
