import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack {
                    TitleView()
                        .padding()
                    
                    HStack {
                        NavigationLink(destination: GameView()) {
                            TextView(text: "Start the game")
                        }
                        NavigationLink(destination: AboutView()) {
                            TextView(text: "About")
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
