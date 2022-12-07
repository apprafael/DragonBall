//
//  UserPosition.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import SwiftUI

struct UserPinView: View {
    var body: some View {
        Triangle()
            .fill(.red)
            .frame(width: 35, height: 30)
    }
}

struct UserPosition_Previews: PreviewProvider {
    static var previews: some View {
        UserPinView()
    }
}
