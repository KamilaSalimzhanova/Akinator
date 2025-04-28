import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var userAnswer: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue, .pink]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                Text("Akinator Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.top, 40)
                
                Image("Akinator")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Text(viewModel.resultText)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                if !viewModel.isGameOver {
                    TextField("Your Answer", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                    
                    Button(action: {
                        if !userAnswer.isEmpty {
                            viewModel.updateGameState(userAnswer: userAnswer)
                            userAnswer = ""
                        }
                    }) {
                        Text("Submit Answer")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .background(LinearGradient(colors: [.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                    }
                } else {
                    Button(action: {
                        viewModel.startNewGame()
                    }) {
                        Text("Start a New Game")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .background(LinearGradient(colors: [.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                    }
                }
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView("Thinking...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameView()
}
