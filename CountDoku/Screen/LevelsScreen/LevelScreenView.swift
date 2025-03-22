//
//  LevelScreenView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 15/1/25.
//

import Combine
import SwiftUI

struct LevelScreenView: View {
    @StateObject private var levelViewModel = LevelViewModel(databaseHelper: DatabaseHelper())

    var body: some View {
        if levelViewModel.navigateToPlayerScreen {
            PlayerScreenView(currentLevel: $levelViewModel.currentLevel, puzzle: $levelViewModel.puzzle, navigateToLevelScreen: $levelViewModel.navigateToPlayerScreen, isAgain: levelViewModel.isAgain)
        } else {
            VStack {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: GameMetadata.getColorFromLevel(currentLevel: levelViewModel.currentLevel)),
                        startPoint: levelViewModel.dynamicStartPoint,
                        endPoint: levelViewModel.dynamicEndPoint
                    )
                    .ignoresSafeArea()
                    .onAppear {
                        levelViewModel.startAnimation()
                    }

                    VStack {
                        Text("level")
                            .font(.custom("Poppins-Thin", size: 64))
                        ZStack {
                            Image("levelShape2")
                                .rotationEffect(.degrees(levelViewModel.rotationAngle))
                                .onAppear {
                                    withAnimation(
                                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                                    ) {
                                        levelViewModel.rotationAngle = 360
                                    }
                                }
                            Image("levelShape1")
                                .rotationEffect(.degrees(levelViewModel.rotationAngle2))
                                .onAppear {
                                    withAnimation(
                                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                                    ) {
                                        levelViewModel.rotationAngle2 = 360
                                    }
                                }
                            SlidingThreeItemsView(currentLevel: $levelViewModel.currentLevel, data: Array(levelViewModel.data.map { $0.0 }), levelViewModel: levelViewModel)
                                .frame(width: UIScreen.main.bounds.width)
                        }
                        .padding(.bottom)

                        if levelViewModel.currentLevel == 1 {
                            if levelViewModel.completedLevels.contains(1) {
                            } else {
                                HStack {
                                    Image("math")
                                    Text("\(GameMetadata.getTotalPuzzles(currentLevel: levelViewModel.currentLevel)) to pass")
                                        .font(.custom("Poppins-Bold", size: 24))
                                        .foregroundColor(Color(UIColor(red: 0.984, green: 1.0, blue: 0.804, alpha: 1.0)))
                                }
                                .padding(.top)
                            }
                        }
                        if levelViewModel.currentLevel > 1 {
                            if levelViewModel.completedLevels.contains(levelViewModel.currentLevel - 1) {
                                if levelViewModel.currentLevel - 1 == levelViewModel.completedLevels.last {
                                    HStack {
                                        Image("math")
                                        Text("\(GameMetadata.getTotalPuzzles(currentLevel: levelViewModel.currentLevel)) to pass")
                                            .font(.custom("Poppins-Bold", size: 24))
                                            .foregroundColor(Color(UIColor(red: 0.984, green: 1.0, blue: 0.804, alpha: 1.0)))
                                    }
                                }
                            } else {
                                HStack {
                                    Image("lock")
                                    Text("Complete Level \(levelViewModel.completedLevels.last! + 1)")
                                        .font(.custom("Poppins-Bold", size: 24))
                                        .foregroundColor(Color(UIColor(red: 0.984, green: 1.0, blue: 0.804, alpha: 1.0)))
                                }
                            }
                        }

                        Spacer()

                        ZStack {
                            Image("levelShape3")
                                .rotationEffect(.degrees(levelViewModel.rotationAngle4))
                                .onAppear {
                                    withAnimation(
                                        Animation.linear(duration: 15).repeatForever(autoreverses: false)
                                    ) {
                                        levelViewModel.rotationAngle4 = 360
                                    }
                                }
                                .padding(.trailing, 300)

                            VStack {
                                Button(action: {
                                    if levelViewModel.currentLevel == 1 || levelViewModel.completedLevels.contains(levelViewModel.currentLevel - 1) {
                                        levelViewModel.saveProgress()
                                        levelViewModel.navigateToPlayerScreen = true
                                    }
                                    
                                    if levelViewModel.completedLevels.contains(levelViewModel.currentLevel) {
                                        levelViewModel.isAgain = true
                                    } else {
                                        levelViewModel.isAgain = false
                                    }
    
                                }) {
                                    Text("PLAY")
                                        .font(.custom("Poppins-Bold", size: 18))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .frame(width: 320, height: 67)
                                .background(.white)
                                .cornerRadius(60)
                                .disabled(!(levelViewModel.completedLevels.contains(levelViewModel.currentLevel - 1) || levelViewModel.currentLevel == 1))
                                .opacity(levelViewModel.completedLevels.contains(levelViewModel.currentLevel - 1) || levelViewModel.currentLevel == 1 ? 1.0 : 0.5)
                                .onAppear {
                                    levelViewModel.loadCompletedLevels()
                                }

                                ZStack {
                                    RoundedRectangle(cornerRadius: 60)
                                        .frame(width: 320, height: 67)
                                        .foregroundColor(.white)
                                        .opacity(0.1)
                                        .overlay {
                                            Button("GO AD-FREE") {
                                                print("Nút được nhấn!")
                                            }
                                            .font(.custom("Poppins-Bold", size: 18))
                                            .foregroundColor(.white)
                                        }
                                }

                                VStack {
                                    Text("By continuing, you agree to our ")
                                        .font(.custom("Poppins-Bold", size: 14))
                                    HStack {
                                        Text("Terms of  conditions")
                                            .font(.custom("Poppins-ExtraBold", size: 14))
                                            .underline()
                                        Text("and acknowledge")
                                            .font(.custom("Poppins-Bold", size: 14))
                                    }
                                    HStack {
                                        Text("our")
                                            .font(.custom("Poppins-Bold", size: 14))
                                        Text("Privacy Policy.")
                                            .font(.custom("Poppins-SemiBold", size: 14))
                                            .underline()
                                    }
                                }
                            }
                        }
                        .offset(y: 90)
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                levelViewModel.fetchData()
                levelViewModel.rotationAngle = 0
                levelViewModel.rotationAngle2 = 0
                levelViewModel.rotationAngle4 = 0
            }
        }
    }
}

#Preview {
    LevelScreenView()
        .environmentObject(DatabaseHelper())
}
