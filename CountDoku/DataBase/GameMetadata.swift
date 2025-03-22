//
//  LevelColor.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 15/1/25.
//
import SwiftUI

struct GameMetadata {
    static func getTotalPuzzles(currentLevel: Int) -> Int {
        switch currentLevel {
        case 1:
            return 3
        default:
           return 5
        }
    }
    static func getColorFromLevel(currentLevel: Int) -> [Color] {
        switch currentLevel {
        case 1:
            return [
                Color(red: 207 / 255, green: 217 / 255, blue: 169 / 255), // #CFD9A9
                Color(red: 153 / 255, green: 205 / 255, blue: 163 / 255), // #99CDA3
                Color(red: 30 / 255, green: 137 / 255, blue: 127 / 255), // #1E897F
            ]
        case 2:
            return  [
                Color(red: 222 / 255, green: 249 / 255, blue: 255 / 255), // #DEF9FF
                Color(red: 133 / 255, green: 164 / 255, blue: 223 / 255), // #85A4DF
                Color(red: 55 / 255, green: 139 / 255, blue: 166 / 255), // #378BA6
                Color(red: 14 / 255, green: 64 / 255, blue: 194 / 255), // #0E40C2
            ]
        case 3:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 4:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 244 / 255), // #FFDEF4
                Color(red: 223 / 255, green: 133 / 255, blue: 214 / 255), // #DF85D6
                Color(red: 62 / 255, green: 2 / 255, blue: 59 / 255)    // #3E023B
            ]
        case 5:
            return [
                Color(red: 255 / 255, green: 189 / 255, blue: 180 / 255), // #FFBDB4
                Color(red: 223 / 255, green: 133 / 255, blue: 133 / 255), // #DF8585
                Color(red: 206 / 255, green: 12 / 255, blue: 0 / 255),   // #CE0C00
            ]
        case 6:
            return [
                Color(red: 255 / 255, green: 215 / 255, blue: 113 / 255), // #FFD771
                Color(red: 245 / 255, green: 184 / 255, blue: 128 / 255), // #F5B880
                Color(red: 183 / 255, green: 90 / 255, blue: 90 / 255),  // #B75A5A
                Color(red: 239 / 255, green: 141 / 255, blue: 141 / 255) // #EF8D8D
            ]
        case 7:
            return [
                Color(red: 255 / 255, green: 232 / 255, blue: 113 / 255), // #FFE871
                Color(red: 168 / 255, green: 204 / 255, blue: 92 / 255),  // #A8CC5C
                Color(red: 171 / 255, green: 200 / 255, blue: 89 / 255),  // #ABC859
                Color(red: 193 / 255, green: 173 / 255, blue: 68 / 255)  // #C1AD44
            ]
        case 8:
            return [
                Color(red: 113 / 255, green: 246 / 255, blue: 255 / 255), // #71F6FF
                Color(red: 92 / 255, green: 204 / 255, blue: 116 / 255),  // #5CCC74
                Color(red: 60 / 255, green: 95 / 255, blue: 186 / 255)   // #3C5FBA
            ]
        case 9:
            return [
                Color(red: 113 / 255, green: 246 / 255, blue: 255 / 255), // #71F6FF
                Color(red: 88 / 255, green: 185 / 255, blue: 226 / 255),  // #58B9E2
                Color(red: 186 / 255, green: 60 / 255, blue: 173 / 255)
            ]
        case 10:
            return [
                Color(red: 235 / 255, green: 255 / 255, blue: 155 / 255), // #EBFF9B
                Color(red: 142 / 255, green: 209 / 255, blue: 209 / 255), // #8ED1D1
                Color(red: 187 / 255, green: 121 / 255, blue: 210 / 255) // #BB79D2
            ]
        case 11:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 12:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 13:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 14:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 15:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 16:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 17:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 18:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 19:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 20:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        case 21:
            return [
                Color(red: 255 / 255, green: 222 / 255, blue: 254 / 255), // #FFDEFE
                Color(red: 146 / 255, green: 133 / 255, blue: 223 / 255), // #9285DF
                Color(red: 84 / 255, green: 55 / 255, blue: 166 / 255), // #5437A6
            ]
        default:
            return [
                Color(red: 207 / 255, green: 217 / 255, blue: 169 / 255), // #CFD9A9
                Color(red: 153 / 255, green: 205 / 255, blue: 163 / 255), // #99CDA3
                Color(red: 30 / 255, green: 137 / 255, blue: 127 / 255), // #1E897F
            ]
        }
    }
 
}
