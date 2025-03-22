//
//  CountDokuApp.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 13/1/25.
//

import SwiftUI


@main
struct CountDokuApp: App {
        
    @StateObject private var databaseHelper = DatabaseHelper()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(databaseHelper)
        }
    }
}

final class DatabaseHelper: ObservableObject {
    var dbPointer: OpaquePointer?
    init() {
        dbPointer = DBHelper.getDatabasePointer(databaseName: "levels.db")
    }
}
