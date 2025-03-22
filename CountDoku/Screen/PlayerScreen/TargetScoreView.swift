//
//  TargetScoreView.swift
//  CountDoku
//
//  Created by Nguyễn Đức Hậu on 19/1/25.
//

import SwiftUI

struct TargetScoreView: View {
    @ObservedObject var viewModel: PlayerViewModel

    var body: some View {
        Text("\(viewModel.scoreTarget)")
            .font(.custom("", size: 120))
            .foregroundColor(.white)
    }
}
