//
//  ControlsView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//
import SwiftUI

struct ControlsView: View {
    @ObservedObject var viewModel: PlayerViewModel

    var body: some View {
        HStack {
            ForEach(["add", "subtract", "multiply", "divide", "reload"], id: \.self) { icon in
                Circle()
                    .fill(.white)
                    .frame(width: 64, height: 64)
                    .opacity(0.15)
                    .overlay {
                        Image(icon)
                            .onTapGesture {
                                handleButtonPress(icon: icon)
                            }
                    }
            }
        }
        .background(
            Image("playerShape2")
                .padding(.top, 10)
                .rotationEffect(.degrees(viewModel.rotationAngle2))
                .allowsHitTesting(false)
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                    ) {
                        viewModel.rotationAngle2 = 360
                    }
                }
        )
    }

    private func handleButtonPress(icon: String) {
        switch icon {
        case "add":
            viewModel.addOperation("+")
        case "subtract":
            viewModel.addOperation("-")
        case "multiply":
            viewModel.addOperation("*")
        case "divide":
            viewModel.addOperation("/")
        case "reload":
            viewModel.resetCalculation()
        default:
            break
        }
    }
}

