import Foundation

class MainGameViewModel: ObservableObject {
    // MARK: - Published variables
    @Published var currentQuestionIndex: Int = 0
    @Published var resultText: String = "Is the character female?"
    @Published var isGameOver: Bool = false
    @Published var finalGuess: String? = nil
    
    // MARK: - Private variables
    private var questionHistory: [(question: String, answer: String)] = []
    private let openAIManager = OpenAIManager.shared
    private let maxQuestions = 10
    private let chatID = 0
    
    // MARK: - Public Functions
    func resetGame() {
        currentQuestionIndex = 0
        resultText = "Is your character female?"
        isGameOver = false
        finalGuess = nil
        questionHistory.removeAll()
    }
    
    func submitAnswer(_ answer: String) {
        questionHistory.append((question: resultText, answer: answer))
        
        if currentQuestionIndex + 1 >= maxQuestions {
            generateFinalGuess()
        } else {
            currentQuestionIndex += 1
            generateNextQuestion()
        }
    }
    
    // MARK: - Private Functions
    private func buildQuestionPrompt() -> String {
        var prompt = """
        You are playing the game Akinator. You must guess the character by asking short yes/no questions.
        Based on the previous questions and answers, suggest the next best question to ask.
        Return ONLY the next question text, no extra comments.
        Here are prev questions and answer: 
        """
        
        for (index, entry) in questionHistory.enumerated() {
            prompt += "Q\(index + 1): \(entry.question)\n"
            prompt += "A\(index + 1): \(entry.answer)\n"
        }
        
        prompt += "\nNext question:"
        return prompt
    }
    
    private func buildFinalGuessPrompt() -> String {
        var prompt = """
            You are playing the game Akinator. Based on the following questions and answers, guess which famous character the user is thinking about.
            Be confident and answer with only the character's name.
            """
        
        for (index, entry) in questionHistory.enumerated() {
            prompt += "Q\(index + 1): \(entry.question)\n"
            prompt += "A\(index + 1): \(entry.answer)\n"
        }
        
        prompt += "\nWho is the character?"
        return prompt
    }
    
    private func generateNextQuestion() {
        let prompt = buildQuestionPrompt()
        
        openAIManager.askAssistant(message: prompt, chatID: chatID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.resultText = response
                case .failure(let error):
                    self?.resultText = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func generateFinalGuess() {
        let prompt = buildFinalGuessPrompt()
        
        openAIManager.askAssistant(message: prompt, chatID: chatID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.finalGuess = response
                    self?.isGameOver = true
                case .failure(let error):
                    self?.finalGuess = "Error: \(error.localizedDescription)"
                    self?.isGameOver = true
                }
            }
        }
    }
}
