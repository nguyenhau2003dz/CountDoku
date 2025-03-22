//
//  PlayerScreenView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 17/1/25.
//

import SwiftUI

struct PlayerScreenView: View {
    @StateObject private var viewModel: PlayerViewModel
    @Binding var currentLevel: Int
    @Binding var navigateToLevelScreen: Bool
    @Binding var puzzle: Int
    var isAgain: Bool
    init(currentLevel: Binding<Int>, puzzle: Binding<Int>, navigateToLevelScreen: Binding<Bool>, isAgain: Bool) {
        _currentLevel = currentLevel
        _puzzle = puzzle
        _navigateToLevelScreen = navigateToLevelScreen
        _viewModel = StateObject(
            wrappedValue: PlayerViewModel(
                databaseHelper: DatabaseHelper(),
                currentLevel: currentLevel.wrappedValue,
                puzzle: puzzle.wrappedValue,
                isAgain: isAgain
            )
        )
        self.isAgain = isAgain
    }

    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: GameMetadata.getColorFromLevel(currentLevel: currentLevel)),
                    startPoint: viewModel.dynamicStartPoint,
                    endPoint: viewModel.dynamicEndPoint
                )
                .ignoresSafeArea()
                .onAppear {
                    viewModel.startAnimation()
                }
                VStack {
                    TopBarView(navigateToLevelScreen: $navigateToLevelScreen, viewModel: viewModel)
                    LevelProgressView(viewModel: viewModel)
                    Spacer()
                    TargetScoreView(viewModel: viewModel)
                    Text(viewModel.currentCalculation)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    EquationView(viewModel: viewModel)
                    Spacer()
                    ControlsView(viewModel: viewModel)
                    Spacer()
                }
            }
            .alert("Correct Answer!", isPresented: $viewModel.correctAnswerAlert) {
                Button("OK", role: .cancel) {
                    viewModel.correctAnswerAlert = false
                }
            }
            .sheet(isPresented: $viewModel.showCompletionScreen) {
                CompletionView(
                    onNextLevel: {
                        viewModel.markLevelAsCompleted(level: currentLevel)
                        currentLevel += 1
                        UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
                        viewModel.updatePuzzle()
                        viewModel.showCompletionScreen = false
                    },
                    onPlayLater: {
                        viewModel.markLevelAsCompleted(level: currentLevel)
                        currentLevel += 1
                        UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
                        navigateToLevelScreen = false
                    },
                    currentLevel: viewModel.currentLevel
                )
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    PlayerScreenView(currentLevel: .constant(1), puzzle: .constant(3), navigateToLevelScreen: .constant(false), isAgain: true)
}
