//
//  ContentView.swift
//  GeometryReader
//
//  Created by Nguyễn Đức Hậu on 16/1/25.
//

import SwiftUI

public struct SlidingThreeItemsView: View {
    @Binding var currentLevel: Int
    var data: [Int]
    @State private var dragOffset: CGFloat = 0
    var levelViewModel: LevelViewModel
    init(currentLevel: Binding<Int>, data: [Int], levelViewModel: LevelViewModel) {
        _currentLevel = currentLevel
        self.data = data
        self.levelViewModel = levelViewModel
    }

    public var body: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width * 0.35
            let spacing = geometry.size.width * 0.1
            let totalItemWidth = itemWidth + spacing
            let centerX = geometry.size.width / 2

            HStack(spacing: spacing) {
                ForEach(data.indices, id: \.self) { index in
                    GeometryReader { itemGeometry in
                        let itemCenterX = itemGeometry.frame(in: .global).midX
                        let distanceToCenter = abs(centerX - itemCenterX)
                        let scale = max(1.0, 1.6 - (distanceToCenter / centerX))
                        Text("\(data[index])")
                            .font(.custom("Poppins-Thin", size: data[index] >= 10 ? 80 * scale : 100 * scale))
                            .frame(width: itemWidth, height: 200)
                            .foregroundColor(.primary)
                            .scaleEffect(scale)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .animation(.spring(), value: currentLevel)
                    }
                    .frame(width: itemWidth, height: 200)
                }
            }
            .padding(.horizontal, (geometry.size.width - itemWidth) / 2)
            .offset(x: -CGFloat(currentLevel - 1) * totalItemWidth + dragOffset) // Adjusted offset
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        let dragThreshold = totalItemWidth / 2
                        if value.translation.width < -dragThreshold, currentLevel < data.count - 1 {
                            currentLevel += 1
                        } else if value.translation.width > dragThreshold, currentLevel > 1 {
                            currentLevel -= 1
                        }
                        dragOffset = 0
                    }
            )
            .onChange(of: currentLevel) { newValue in
                levelViewModel.updatePuzzle(newLevel: newValue)
            }
        }
    }
}
