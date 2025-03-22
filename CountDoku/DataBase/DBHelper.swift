//
//  DBHelper.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 15/1/25.
//

import Foundation
import SQLite3

class DBHelper {
    static func getDatabasePointer(databaseName: String) -> OpaquePointer? {
        var databasePointer: OpaquePointer?

        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0].appendingPathComponent(databaseName).path

        if FileManager.default.fileExists(atPath: documentDatabasePath) {
            print("Database Exists (already)")
        } else {
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else {
                print("Unwraping error: Bundle Database Path doesn't exist")
                return nil
            }

            do {
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database created: (copied)")
            } catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
        }
        if sqlite3_open(documentDatabasePath, &databasePointer) == SQLITE_OK {
            print("Successfully open Database")
            print("Database path: \(documentDatabasePath)")
        } else {
            print("Counldn't open Database")
        }
        return databasePointer
    }

    static func fetchDataGameMetadata(dbPointer: OpaquePointer?) -> [(Int, Int)] {
        guard let db = dbPointer else { return [] }
        var queryStatement: OpaquePointer?
        let queryString = "SELECT level, totalPuzzles FROM GameMetadata;" // Truy vấn cột cần thiết
        var results = [(Int, Int)]()

        if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let level = sqlite3_column_int(queryStatement, 0) // Cột đầu tiên: level
                let totalPuzzles = sqlite3_column_int(queryStatement, 1) // Cột thứ hai: totalPuzzles
                results.append((Int(level), Int(totalPuzzles)))
            }
            sqlite3_finalize(queryStatement)
        } else {
            print("Query preparation failed: \(String(cString: sqlite3_errmsg(db)))")
        }
        return results
    }

    static func fetchLevelData(dbPointer: OpaquePointer?, forLevel level: Int) -> [(Int, [Int], Int, String)] {
        guard let db = dbPointer else {
            print("Database pointer is nil.")
            return []
        }
        var queryStatement: OpaquePointer?

        // Xác định tên bảng dựa trên `level`
        let tableName = "Level_\(level)"
        let queryString = "SELECT level, numbers, target, hint FROM \(tableName) WHERE level = ?;"
        var results = [(Int, [Int], Int, String)]()

        if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(level)) // Gắn giá trị `level` vào câu truy vấn

            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let fetchedLevel = sqlite3_column_int(queryStatement, 0)

                // Chuyển đổi cột `numbers` thành mảng `Int`
                let numbersString = String(cString: sqlite3_column_text(queryStatement, 1))
                let numbers = numbersString
                    .split(separator: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                let target = sqlite3_column_int(queryStatement, 2)
                let hint = String(cString: sqlite3_column_text(queryStatement, 3))

                results.append((Int(fetchedLevel), numbers, Int(target), hint))
            }
            sqlite3_finalize(queryStatement)
        } else {
            print("Query preparation failed for table \(tableName): \(String(cString: sqlite3_errmsg(db)))")
        }

        if results.isEmpty {
            print("No results found for \(tableName) with level \(level).")
        }
        return results
    }
}
