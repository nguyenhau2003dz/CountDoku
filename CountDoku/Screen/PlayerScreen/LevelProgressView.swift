//
//  LevelProgressView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//

import SwiftUI

struct LevelProgressView: View {
    @ObservedObject var viewModel: PlayerViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Level ")
                    .font(.custom("Poppins-Thinn", size: 14))
                    .foregroundColor(.white)
                    + Text("\(viewModel.currentLevel)")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                if !viewModel.isAgain {
                    Text("\(viewModel.puzzle) to go")
                        .font(.custom("Poppins-Thinn", size: 24))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Level ")
                    .font(.custom("Poppins-Thinn", size: 14))
                    .foregroundColor(.white)
                    + Text("\(viewModel.currentLevel + 1)")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 22)

            ProgressView(value: viewModel.isAgain == true ? 1: Double(viewModel.totalPuzzles - viewModel.puzzle) / Double(viewModel.totalPuzzles))
                .padding(.horizontal, 22)
                .tint(Color.white)
        }
    }
}
