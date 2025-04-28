import SwiftUI

struct GameView: View {
    @StateObject var viewModel = OpenAIViewModel()
    @State private var isStarted = false
    @State private var showComment = false
    @State private var rotateImage = false
    @State private var gameProgress = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue, .pink]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Text("Akinator Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .shadow(radius: 10)
                    .padding(.top, 40)
                
                Spacer()
                
                Image("Akinator")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(rotateImage ? 360 : 0))
                    .animation(.easeInOut(duration: 7).repeatForever(autoreverses: false), value: rotateImage)
                    .onAppear {
                        rotateImage.toggle()
                    }
                
                Spacer()
                
                ProgressView("Game Progress", value: gameProgress, total: 100)
                    .progressViewStyle(DefaultProgressViewStyle())
                    .padding()
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(width: 300)
                
                Button(action: {
                    withAnimation {
                        isStarted.toggle()
                        gameProgress = isStarted ? 100 : 0
                    }
                }) {
                    Text(isStarted ? "Restart Game" : "Start the Game")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .background(LinearGradient(colors: [.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }
                
                Button(action: {
                    showComment.toggle()
                }) {
                    Text("Leave a comment")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }
                
                Spacer()
                
                if showComment {
                    Text("Great choice! You're playing as the Genie!")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.5))
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    GameView()
}
