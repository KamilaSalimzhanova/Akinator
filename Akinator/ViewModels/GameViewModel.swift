import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var resultText: String = "Welcome to the game! Think of a character, and I will guess it!"
    @Published var isLoading: Bool = false
    @Published var previousAnswers: [String] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var isGameOver: Bool = false
    
    private var openAIViewModel = OpenAIViewModel()
    
    func startNewGame() {
        previousAnswers = []
        currentQuestionIndex = 0
        resultText = "Welcome to the game! Think of a character, and I will guess it!"
        isGameOver = false
    }
    
    func updateGameState(userAnswer: String) {
        previousAnswers.append(userAnswer)
        currentQuestionIndex += 1
        
        let prompt = generatePrompt(userAnswer: userAnswer)
        fetchOpenAIResponse(prompt: prompt)
    }
    
    private func generatePrompt(userAnswer: String) -> String {
        let history = previousAnswers.joined(separator: " ")
        return """
        Based on the answers so far: \(history). Ask the next question to guess the character, or make a guess if you're confident.
        """
    }
    
    private func fetchOpenAIResponse(prompt: String) {
        isLoading = true
        
        openAIViewModel.fetchOpenAIResponse(prompt: prompt) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                if result.contains("I guess") || result.contains("Is it") {
                    self?.resultText = "I think your character is: \(result)"
                    self?.isGameOver = true
                } else {
                    self?.resultText = result
                }
            }
        }
    }
}
