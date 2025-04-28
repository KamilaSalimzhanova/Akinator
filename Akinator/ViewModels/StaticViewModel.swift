import SwiftUI

class StaticGameViewModel: ObservableObject {
    @Published var currentQuestionIndex: Int = 0
    @Published var resultText: String = ""
    @Published var isGameOver: Bool = false
    @Published var finalGuess: String? = nil
    
    private var questionHistory: [(question: String, answer: String)] = []
    
    private let celebrities: [String: [(question: String, answer: String)]] = [
        "Robert Downey Jr.": [
            ("Is this person male?", "Yes"),
            ("Is this person an actor?", "Yes"),
            ("Is this person American?", "Yes"),
            ("Is this person known for playing in superhero movies?", "Yes"),
            ("Is this person Iron Man?", "Yes")
        ],
        "Emma Watson": [
            ("Is this person female?", "Yes"),
            ("Is this person an actor?", "Yes"),
            ("Is this person British?", "Yes"),
            ("Is this person known for playing Hermione Granger?", "Yes"),
            ("Has this person been involved in women's rights advocacy?", "Yes")
        ],
        "Albert Einstein": [
            ("Is this person male?", "Yes"),
            ("Is this person a scientist?", "Yes"),
            ("Is this person known for his work in physics?", "Yes"),
            ("Did this person receive a Nobel Prize?", "Yes"),
            ("Is this person Albert Einstein?", "Yes")
        ],
        "Beyoncé": [
            ("Is this person female?", "Yes"),
            ("Is this person a musician?", "Yes"),
            ("Is this person American?", "Yes"),
            ("Has this person been part of a famous girl group?", "Yes"),
            ("Is this person Beyoncé?", "Yes")
        ]
    ]
    
    private var possibleCelebrities: [String] = []
    private let maxQuestions = 5
    
    private let questions: [String] = [
        "Is this person male?",
        "Is this person an actor?",
        "Is this person a musician?",
        "Is this person American?",
        "Is this person British?",
        "Has this person won an Oscar?",
        "Has this person ever been a part of a famous movie franchise?",
        "Is this person known for their role in superhero movies?",
        "Is this person still alive?",
        "Is this person older than 50?",
        "Is this person known for their work in science or technology?",
        "Has this person written a book?",
        "Is this person involved in political activism?",
        "Is this person a sports player?",
        "Is this person known for their role in a popular TV show?",
        "Has this person ever been married?",
        "Is this person known for their philanthropic work?",
        "Is this person famous for their social media presence?",
        "Is this person a billionaire?"
    ]
    
    func resetGame() {
        currentQuestionIndex = 0
        resultText = questions[currentQuestionIndex]
        isGameOver = false
        finalGuess = nil
        questionHistory.removeAll()
        possibleCelebrities = Array(celebrities.keys)
    }
    
    func submitAnswer(_ answer: String) {
        questionHistory.append((question: resultText, answer: answer))
        
        possibleCelebrities = possibleCelebrities.filter { celebrity in
            guard let celebrityQuestions = celebrities[celebrity] else { return false }
            
            for (index, entry) in celebrityQuestions.prefix(currentQuestionIndex + 1).enumerated() {
                if entry.answer != (index < questionHistory.count ? questionHistory[index].answer : "") {
                    return false
                }
            }
            return true
        }
        
        if currentQuestionIndex + 1 < maxQuestions {
            currentQuestionIndex += 1
            generateNextQuestion()
        } else {
            finalGuess = possibleCelebrities.first
            isGameOver = true
        }
    }
    
    func generateNextQuestion() {
        resultText = questions[currentQuestionIndex]
    }
}
