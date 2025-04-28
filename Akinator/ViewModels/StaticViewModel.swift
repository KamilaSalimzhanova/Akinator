import SwiftUI

class StaticGameViewModel: ObservableObject {
    // MARK: - Publishers
    @Published var currentQuestionIndex: Int = 0
    @Published var resultText: String = ""
    @Published var isGameOver: Bool = false
    @Published var finalGuess: String? = nil
    
    // MARK: - Private variables
    private var celebrities: [Celebrity] = []
    private var possibleCelebrities: [Celebrity] = []
    private var askedAttributes: Set<String> = []
    private let maxQuestions = 5
    private let questions: [(attribute: String, questionText: String)] = [
        ("male", "Is this person male?"),
        ("actor", "Is this person an actor?"),
        ("musician", "Is this person a musician?"),
        ("american", "Is this person American?"),
        ("british", "Is this person British?"),
        ("superhero_actor", "Is this person known for superhero movies?"),
        ("alive", "Is this person still alive?"),
        ("older_than_50", "Is this person older than 50?"),
        ("scientist", "Is this person a scientist?"),
        ("oscar_winner", "Has this person won an Oscar?"),
        ("billionaire", "Is this person a billionaire?")
    ]
    private let initialCelebrities: [Celebrity] = [
        Celebrity(name: "Robert Downey Jr.", attributes: ["male": true, "actor": true, "musician": false, "american": true, "british": false, "superhero_actor": true, "alive": true, "older_than_50": true, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Emma Watson", attributes: ["male": false, "actor": true, "musician": false, "american": false, "british": true, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Albert Einstein", attributes: ["male": true, "actor": false, "musician": false, "american": true, "british": false, "superhero_actor": false, "alive": false, "older_than_50": true, "scientist": true, "oscar_winner": true, "billionaire": false]),
        Celebrity(name: "Beyoncé", attributes: ["male": false, "actor": false, "musician": true, "american": true, "british": false, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": true]),
        Celebrity(name: "Leonardo DiCaprio", attributes: ["male": true, "actor": true, "musician": false, "american": true, "british": false, "superhero_actor": false, "alive": true, "older_than_50": true, "scientist": false, "oscar_winner": true, "billionaire": false]),
        Celebrity(name: "Taylor Swift", attributes: ["male": false, "actor": false, "musician": true, "american": true, "british": false, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": true]),
        Celebrity(name: "Stephen Hawking", attributes: ["male": true, "actor": false, "musician": false, "american": false, "british": true, "superhero_actor": false, "alive": false, "older_than_50": true, "scientist": true, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Adele", attributes: ["male": false, "actor": false, "musician": true, "american": false, "british": true, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Tom Holland", attributes: ["male": true, "actor": true, "musician": false, "american": false, "british": true, "superhero_actor": true, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Elon Musk", attributes: ["male": true, "actor": false, "musician": false, "american": true, "british": false, "superhero_actor": false, "alive": true, "older_than_50": true, "scientist": true, "oscar_winner": false, "billionaire": true]),
        Celebrity(name: "Billie Eilish", attributes: ["male": false, "actor": false, "musician": true, "american": true, "british": false, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": true, "billionaire": false]),
        Celebrity(name: "Chris Hemsworth", attributes: ["male": true, "actor": true, "musician": false, "american": false, "british": false, "superhero_actor": true, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Margot Robbie", attributes: ["male": false, "actor": true, "musician": false, "american": false, "british": false, "superhero_actor": false, "alive": true, "older_than_50": false, "scientist": false, "oscar_winner": false, "billionaire": false]),
        Celebrity(name: "Albert Einstein", attributes: ["male": true, "actor": false, "musician": false, "american": true, "british": false, "superhero_actor": false, "alive": false, "older_than_50": true, "scientist": true, "oscar_winner": true, "billionaire": false])
    ]
    
    // MARK: - Initialization
    init() {
        resetGame()
    }
    
    // MARK: - Public functions
    func resetGame() {
        celebrities = initialCelebrities
        possibleCelebrities = celebrities
        askedAttributes = []
        currentQuestionIndex = 0
        isGameOver = false
        finalGuess = nil
        generateNextQuestion()
    }
    
    func submitAnswer(_ answer: String) {
        guard currentQuestionIndex < questions.count else { return }
        
        let currentAttribute = questions[currentQuestionIndex].attribute
        
        if answer == "Yes" {
            possibleCelebrities = possibleCelebrities.filter { $0.attributes[currentAttribute] == true }
        } else if answer == "No" {
            possibleCelebrities = possibleCelebrities.filter { $0.attributes[currentAttribute] == false }
        }
        askedAttributes.insert(currentAttribute)
        
        if possibleCelebrities.count <= 1 || askedAttributes.count >= maxQuestions {
            finishGame()
        } else {
            generateNextQuestion()
        }
    }
    
    func generateNextQuestion() {
        if let next = questions.first(where: { !askedAttributes.contains($0.attribute) }) {
            resultText = next.questionText
            currentQuestionIndex = questions.firstIndex(where: { $0.attribute == next.attribute }) ?? 0
        } else {
            finishGame()
        }
    }
    
    // MARK: - Private functions
    private func finishGame() {
        finalGuess = possibleCelebrities.first?.name ?? "I couldn't guess!"
        isGameOver = true
    }
}
