//
//  EquationView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//

import SwiftUI

struct EquationView: View {
    @ObservedObject var viewModel: PlayerViewModel
    var body: some View {
        VStack {
            Text("Make \(viewModel.scoreTarget) using:")
                .font(.custom("", size: 24))
                .foregroundColor(Color(UIColor(red: 0.984, green: 1.0, blue: 0.804, alpha: 1.0)))
            HStack {
                ForEach(viewModel.numbers, id: \.self) { number in
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 72, height: 72)
                        .overlay {
                            Text("\(number)")
                                .font(.custom("", size: 47.5))
                                .foregroundColor(.white)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.addNumberToCalculation(number)
                        }
                }
            }
        }
    }
}
