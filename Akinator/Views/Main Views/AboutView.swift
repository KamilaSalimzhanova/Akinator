import SwiftUI

struct AboutView: View {
    @State private var fadeIn = false
    @Environment(\.presentationMode) var dismiss
    var body: some View {
        ZStack(alignment: .topTrailing) {
            BackgroundView().ignoresSafeArea()
            VStack {
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    Text("""
                Akinator is a magical game where the Genie tries to guess the character you're thinking of by asking a series of questions! 🤔✨
                
                Think of a real or fictional character, and see if the Genie can figure it out!
                
                The more honestly you answer, the more accurate the Genie's guess will be. 🌟  
                Challenge yourself: can you outsmart the Genie?
                
                This project was created to capture the spirit of the classic Akinator game, while adding new styles and a fresh mobile experience. 📱🎮
                
                Have fun and enjoy the magic of guessing! ✨🧞‍♂️
                """)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeIn(duration: 1.5).delay(0.5), value: fadeIn)
                    .clipped()
                }
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(radius: 5)
                Spacer()
                HomeBackButton(presentationMode: _dismiss, frameMax: true)
            
            }
            .padding()
        }
        .onAppear {
            fadeIn = true
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("About the Game 🪄")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    AboutView()
}
