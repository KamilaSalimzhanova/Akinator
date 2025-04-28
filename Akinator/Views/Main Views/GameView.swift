import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: StaticGameViewModel
    
    var body: some View {
        ZStack {
            BackgroundView().ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    NavigationLink {
                        MainView()
                    } label: {
                        Text("Home 🏡")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    
                }
                .padding(.horizontal)
                
                QuestionBubbleView(questionNumber: vm.currentQuestionIndex, questionText: vm.resultText)
                
                Image("AkinatorAskQuestion")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                    .offset(x: 40, y: -40)
                
                Spacer()
                
                AnswerButtonsView()
                
            }
            if vm.isGameOver {
                ResultView(finalGuess: vm.finalGuess) {
                    vm.resetGame() 
                }
                .transition(.opacity)
                .animation(.easeInOut, value: vm.isGameOver)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView().environmentObject(StaticGameViewModel())
}
