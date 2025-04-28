import SwiftUI

struct ResultView: View {
    var finalGuess: String?
    var onPlayAgain: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(finalGuess ?? "I couldn't guess it.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Button(action: onPlayAgain) {
                    Text("Play Again")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.bottom)
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color.green)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: finalGuess != nil)
    }
}

#Preview {
    ResultView(finalGuess: "Robert Jr.", onPlayAgain: {})
}
