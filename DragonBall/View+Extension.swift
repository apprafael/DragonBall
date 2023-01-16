//
//  View+Extension.swift
//  DragonBall
//
//  Created by Rafael Almeida on 1/13/23.
//

import SwiftUI

extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
