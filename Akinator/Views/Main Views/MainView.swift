import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: StaticGameViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack {
                    TitleView()
                        .padding()
                    
                    HStack {
                        NavigationLink(destination: GuessCharacterView()) {
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
    MainView().environmentObject(StaticGameViewModel())
}
