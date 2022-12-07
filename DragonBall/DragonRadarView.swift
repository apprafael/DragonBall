//
//  ContentView.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import SwiftUI
import AVKit

struct DragonRadarView: View {
    @State var audioPlayer: AVAudioPlayer!
    var viewModel = DragonRadarViewModel()
    var body: some View {
        ZStack(alignment: .center) {
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 3) {
                ForEach(0...10, id: \.self) {_ in
                    HStack(spacing: 3) {
                        ForEach(0...10, id: \.self) {_ in
                            Rectangle()
                                .fill(Color("radarbackground"))
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
            .offset(x: -8, y: -10)
            .ignoresSafeArea()
            
            UserPinView()
                
            ForEach(viewModel.dragonBalls) { dragonBall in
                DragonBallView()
                    .offset(x: CGFloat(dragonBall.positionX), y: CGFloat(dragonBall.positionY))
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "bip", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.numberOfLoops = -1
            self.audioPlayer.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DragonRadarView()
    }
}
