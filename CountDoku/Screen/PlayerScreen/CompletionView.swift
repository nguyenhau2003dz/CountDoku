//
//  CompletionView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 4/2/25.
//
import SwiftUI

struct CompletionView: View {
    var onNextLevel: () -> Void
    var onPlayLater: () -> Void
    @State private var angle: Double = 0
    @State var rotationAngle: Double = 0
    @State var rotationAngle2: Double = 0
    var currentLevel: Int = 9
    
    var dynamicStartPoint: UnitPoint {
        UnitPoint(
            x: 0.5 + 0.5 * cos(angle),
            y: 0.5 + 0.5 * sin(angle)
        )
    }

    var dynamicEndPoint: UnitPoint {
        UnitPoint(
            x: 0.5 - 0.5 * cos(angle),
            y: 0.5 - 0.5 * sin(angle)
        )
    }

    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true) { _ in
            self.angle += 0.01
            if self.angle > .pi * 2 {
                self.angle -= .pi * 2
            }
        }
    }

    var body: some View {
        VStack {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 227 / 255, green: 255 / 255, blue: 113 / 255), // #E3FF71
                        Color(red: 153 / 255, green: 203 / 255, blue: 158 / 255), // #99CB9E
                        Color(red: 180 / 255, green: 201 / 255, blue: 153 / 255), // #B4C999
                    ]),
                    center: .topTrailing, // Center of the gradient
                    startRadius: 20, // Start radius
                    endRadius: 200 // End radius
                )
                .ignoresSafeArea()
                .onAppear {
                    self.startAnimation()
                }
                VStack {
                    Image("tick")
                        .background(
                            Image("tickShape")
                                .background(
                                    Image("correctShape2")
                                        .rotationEffect(.degrees(rotationAngle))
                                        .allowsHitTesting(false)
                                        .onAppear {
                                            withAnimation(
                                                Animation.linear(duration: 15).repeatForever(autoreverses: false)
                                            ) {
                                                rotationAngle2 = 360
                                            }
                                        }
                                )
                        )
                    Text("Level \(currentLevel) Passed!")
                        .foregroundColor(.white)
                        .font(.system(size: 48))
                        .padding(.top, 60)

                    Text("Would you like to go to the next level?")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color(UIColor(red: 0.984, green: 1.0, blue: 0.804, alpha: 1.0)))
                        .frame(width: 200)
                        .multilineTextAlignment(.center)

                    VStack {
                        Button(action: onNextLevel) {
                            Text("Next Level")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(width: 320, height: 67)
                        .background(.white)
                        .cornerRadius(60)

                        Button(action: onPlayLater) {
                            Text("Play Later")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(width: 320, height: 67)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(60)
                    }
                    .padding(.top, 100)
                }
                .padding(.top, 150)

                Image("correctShape")
                    .rotationEffect(.degrees(rotationAngle))
                    .allowsHitTesting(false)
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 15).repeatForever(autoreverses: false)
                        ) {
                            rotationAngle = 360
                        }
                    }
                    .padding(.top, 900)
            }
        }
    }
}

#Preview {
    CompletionView(onNextLevel: {}, onPlayLater: {})
}
