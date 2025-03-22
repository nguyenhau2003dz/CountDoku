// LevelViewModel.swift
// CountDoku
// Created by Nguyễn Đức Hậu on 19/1/25.

import Combine
import SwiftUI

class LevelViewModel: ObservableObject {
    @Published var isAgain: Bool = false
    
    @Published var rotationAngle: Double = 0
    @Published var rotationAngle2: Double = 0
    @Published var rotationAngle3: Double = 0
    @Published var rotationAngle4: Double = 0
    @Published var angle: Double = 0

    @Published var currentLevel: Int = 1
    @Published var completedLevels: [Int] = []

    @Published var puzzle: Int = 0
    @Published var data: [(Int, Int)] = []
    @Published var isButtonDisabled = true
    @Published var navigateToPlayerScreen = false

    private var databaseHelper: DatabaseHelper

    // 1 - Được gọi lần đầu
    init(databaseHelper: DatabaseHelper) {
        self.databaseHelper = databaseHelper
        if let savedLevels = UserDefaults.standard.array(forKey: "completedLevels") as? [Int] {
            completedLevels = savedLevels
        } else {
            completedLevels = [0]
            UserDefaults.standard.set(completedLevels, forKey: "completedLevels")
        }
    }

    // Hàm load các level đã hoàn thành
    func loadCompletedLevels() {
        if let savedLevels = UserDefaults.standard.array(forKey: "completedLevels") as? [Int] {
            completedLevels = savedLevels
        } else {
            completedLevels = []
            UserDefaults.standard.set(completedLevels, forKey: "completedLevels")
        }
    }

    // 2 - Lấy data đổ lên và set puzzle tương ứng
    func fetchData() {
        if UserDefaults.standard.object(forKey: "currentLevel") == nil {
            UserDefaults.standard.set(1, forKey: "currentLevel")
        }
        currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")

        if let db = databaseHelper.dbPointer {
            print("Database is ready.")
            data = DBHelper.fetchDataGameMetadata(dbPointer: db)
            if let levelData = data.first(where: { $0.0 == currentLevel }) {
                puzzle = levelData.1
            }
            print("Fetched data: \(data)")
        } else {
            print("Database failed to initialize.")
        }
    }

    func updatePuzzle(newLevel: Int? = nil) {
        let levelToFetch = newLevel ?? UserDefaults.standard.integer(forKey: "currentLevel")
        if let db = databaseHelper.dbPointer {
            print("Database is ready.")
            data = DBHelper.fetchDataGameMetadata(dbPointer: db)
            if let levelData = data.first(where: { $0.0 == levelToFetch }) {
                puzzle = levelData.1
            }
            print("Fetched data: \(data)")
        } else {
            print("Database failed to initialize.")
        }
    }

    func saveProgress() {
        UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
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
