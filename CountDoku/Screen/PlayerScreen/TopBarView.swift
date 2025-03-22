//
//  TopBarView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//

import SwiftUI

struct TopBarView: View {
    @Binding var navigateToLevelScreen: Bool
    @ObservedObject var viewModel: PlayerViewModel
    var body: some View {
        HStack {
            ZStack {
                Image("playerShape1")
                    .rotationEffect(.degrees(viewModel.rotationAngle))
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 15).repeatForever(autoreverses: false)
                        ) {
                            viewModel.rotationAngle = 360
                        }
                    }
                Image("back")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .onTapGesture {
                        navigateToLevelScreen = false
                    }
            }
            Spacer()
        }
        .padding(.leading, 16)
    }
}
