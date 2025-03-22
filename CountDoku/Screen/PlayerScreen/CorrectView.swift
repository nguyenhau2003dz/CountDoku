import SwiftUI

struct CorrectView: View {
    @State private var angle: Double = 0
    @State var rotationAngle: Double = 0
    @State var rotationAngle2: Double = 0

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

    var body: some View {
        VStack {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 227 / 255, green: 255 / 255, blue: 113 / 255), // #E3FF71
                        Color(red: 153 / 255, green: 203 / 255, blue: 158 / 255), // #99CB9E
                        Color(red: 180 / 255, green: 201 / 255, blue: 153 / 255), // #B4C999
                    ]),
                    center: .topTrailing, // Center of the gradient
                    startRadius: 50, // Start radius
                    endRadius: 500 // End radius
                )
                .ignoresSafeArea()
                .onAppear {
                    self.startAnimation()
                }
                VStack {
                    Image("tick")
                        .background(
                            Image("tickShape")
                                .background(
                                    Image("correctShape2")
                                        .rotationEffect(.degrees(rotationAngle))
                                        .onAppear {
                                            withAnimation(
                                                Animation.linear(duration: 15).repeatForever(autoreverses: false)
                                            ) {
                                                rotationAngle2 = 360
                                            }
                                        }
                                )
                        )
                    Text("Correct!")
                        .foregroundColor(.white)
                        .font(.system(size: 48))
                        .padding(.top)
                }

                Image("correctShape")
                    .rotationEffect(.degrees(rotationAngle))
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 15).repeatForever(autoreverses: false)
                        ) {
                            rotationAngle = 360
                        }
                    }
                    .padding(.top, 900)
            }
        }
    }
}

#Preview {
    CorrectView()
}
