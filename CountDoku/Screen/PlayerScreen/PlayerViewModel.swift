//
//  PlayerViewModel.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//

import Combine
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var rotationAngle: Double = 0
    @Published var rotationAngle2: Double = 0
    @Published var angle: Double = 0

    @Published var data: [(Int, [Int], Int, String)] = []
    @Published var data2: [(Int, Int)] = []

    @Published var numbers: [Int] = []
    @Published var scoreTarget: Int = 0
    @Published var stringCalculate: String = ""
    @Published var currentCalculation: String = " "

    @Published var puzzle: Int
    @Published var currentLevel: Int
    @Published var isAgain: Bool

    @Published var correctAnswerAlert = false
    @Published var showCompletionScreen = false

    private var databaseHelper: DatabaseHelper

    @Published var totalPuzzles: Int = 1

    init(databaseHelper: DatabaseHelper, currentLevel: Int, puzzle: Int, isAgain: Bool) {
        self.databaseHelper = databaseHelper
        self.currentLevel = currentLevel
        self.puzzle = puzzle
        self.isAgain = isAgain
        fetchData()
    }

    func fetchData() {
        if let db = databaseHelper.dbPointer {
            data = DBHelper.fetchLevelData(dbPointer: db, forLevel: currentLevel)
            if let firstElement = data.randomElement() {
                numbers = firstElement.1
                scoreTarget = firstElement.2
                stringCalculate = firstElement.3
            }
            data2 = DBHelper.fetchDataGameMetadata(dbPointer: db)
            if let levelData = data2.first(where: { $0.0 == currentLevel }) {
                totalPuzzles = levelData.1
            }
        } else {
            print("Database failed to initialize.")
        }
    }

    func updatePuzzle() {
        currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
        if let db = databaseHelper.dbPointer {
            print("Database is ready.")
            data2 = DBHelper.fetchDataGameMetadata(dbPointer: db)
            if let levelData = data2.first(where: { $0.0 == currentLevel }) {
                puzzle = levelData.1
                totalPuzzles = levelData.1
            }
        } else {
            print("Database failed to initialize.")
        }
        fetchData()
    }

    func addNumberToCalculation(_ number: Int) {
        currentCalculation += "\(number)"
        calculateIfComplete()
    }

    func addOperation(_ operation: String) {
        if !currentCalculation.isEmpty && "+-*/".contains(currentCalculation.last!) {
            currentCalculation.removeLast()
        }
        currentCalculation += operation
        calculateIfComplete()
    }

    func resetCalculation() {
        currentCalculation = " "
    }

    private func calculateIfComplete() {
        guard !currentCalculation.isEmpty, !"+-*/".contains(currentCalculation.last!) else { return }

        let expression = NSExpression(format: currentCalculation)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            print("Intermediate calculation result: \(result)")

            // Tính giá trị thực tế của stringCalculate
            let targetExpression = NSExpression(format: stringCalculate)
            if let targetResult = targetExpression.expressionValue(with: nil, context: nil) as? Int {
                if result == targetResult {
                    if isAgain {
                        DispatchQueue.main.async {
                            self.correctAnswerAlert = true // Đảm bảo alert được hiển thị
                        }
                        resetCalculation()
                        fetchData()
                    } else {
                        puzzle -= 1
                        DispatchQueue.main.async {
                            self.correctAnswerAlert = true // Đảm bảo alert được hiển thị
                        }
                        print("Correct Answer! Puzzle remaining: \(puzzle)")
                        resetCalculation()

                        // Random lại dữ liệu
                        fetchData()

                        if puzzle == 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.showCompletionScreen = true
                            }
                        }
                    }
                } else {
                    print("Incorrect Answer. Expected: \(targetResult), Got: \(result)")
                }
            } else {
                print("Failed to calculate target expression: \(stringCalculate)")
            }
        } else {
            print("Invalid calculation.")
        }
    }

    func markLevelAsCompleted(level: Int) {
        if let savedLevels = UserDefaults.standard.array(forKey: "completedLevels") as? [Int] {
            var levels = savedLevels
            if !levels.contains(level) {
                levels.append(level)
                UserDefaults.standard.set(levels, forKey: "completedLevels")
            }
        } else {
            UserDefaults.standard.set([level], forKey: "completedLevels")
        }
    }

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
}
