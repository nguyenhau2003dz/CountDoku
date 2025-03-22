//
//  SplashView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 13/1/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isSplashActive = true
    var body: some View {
        Group {
            if isSplashActive {
                SplashContent()
            } else {
                LevelScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isSplashActive = false
                }
            }
        }
    }
}

struct SplashContent: View {
    @State private var rotationAngle: Double = 0
    @State private var rotationAngle2: Double = 0
    @State private var rotationAngle3: Double = 0
    @State private var rotationAngle4: Double = 0
    @State private var rotationAngle5: Double = 0
    @State private var navigateToNext: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 235 / 255, green: 255 / 255, blue: 155 / 255),
                    Color(red: 142 / 255, green: 209 / 255, blue: 209 / 255),
                    Color(red: 187 / 255, green: 121 / 255, blue: 210 / 255),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            Image("shape4")
                .rotationEffect(.degrees(rotationAngle4))
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                    ) {
                        rotationAngle4 = 360
                    }
                }
            Image("shape3")
                .rotationEffect(.degrees(rotationAngle3))
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                    ) {
                        rotationAngle3 = 360
                    }
                }

            Image("shape2")
                .rotationEffect(.degrees(rotationAngle2))
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                    ) {
                        rotationAngle2 = 360
                    }
                }
            Image("shape1")
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 5).repeatForever(autoreverses: false)
                    ) {
                        rotationAngle = 360
                    }
                }
            VStack {
                Text("COUNT")
                    .font(.custom("Poppins-Thin", size: 72))
                Text("DOKU")
                    .font(.custom("Poppins-ExtraBold", size: 40))

                Image("shape5")
                    .rotationEffect(.degrees(rotationAngle5))
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 5).repeatForever(autoreverses: false)
                        ) {
                            rotationAngle5 = 360
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(DatabaseHelper())
}
