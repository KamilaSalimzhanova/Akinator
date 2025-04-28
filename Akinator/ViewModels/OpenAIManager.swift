import Foundation
import OpenAI

final class OpenAIManager {
    let storage: DataStorageProtocol = DataStorage()
    static let shared = OpenAIManager()
    private init() {}
    
    private lazy var openAI: OpenAI = {
        if let path = Bundle.main.path(forResource: "Resources/info", ofType: "plist"),
           let secrets = NSDictionary(contentsOfFile: path),
           let apiKey = secrets["API_KEY"] as? String, !apiKey.isEmpty {
            print("✅ API Key loaded")
            return OpenAI(apiToken: apiKey)
        }
        print("❌ API Key missing or invalid")
        return OpenAI(apiToken: "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")
    }()


    
    func askAssistant(
        message: String,
        chatID: Int,
        completion: @escaping (
            Result<String, Error>
        ) -> (Void)
    ) {
        let currentAssistantId = getChatbotID(chatID: chatID)
        getThreadID(for: chatID) { [weak self] threadID in
            guard let self = self else { return }
            
            let query = MessageQuery(role: .user, content: message)
            
            openAI.threadsAddMessage(threadId: threadID, query: query) { result in
                switch result {
                case .success(_):
                    
                    let runsQuery = RunsQuery(assistantId: currentAssistantId)
                    
                    self.openAI.runs(threadId: threadID, query: runsQuery) { runResponse in
                        switch runResponse {
                        case .success(let success):
                            self.pollForCompletion(threadId: threadID, runId: success.id, completion: completion)
                        case .failure(let failure):
                            completion(.failure(failure))
                        }
                    }
                    
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    private func pollForCompletion(threadId: String, runId: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAI.runRetrieve(threadId: threadId, runId: runId) { result in
            
            switch result {
            case .success(let status):
                if status.status == .completed {
                    
                    self.openAI.threadsMessages(threadId: threadId) { result in
                        switch result {
                        case .success(let result):
                            let response = result.data.first?.content.last?.text?.value ?? ""
                            completion(.success(response))
                            //print("Result of threadsmessages: ", result)
                        case .failure(let error):
                            //print(error.localizedDescription)
                            completion(.failure(error))
                        }
                    }
                } else {
                    // If not completed, wait and check again
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1) { // Poll every 2 seconds
                        self.pollForCompletion(threadId: threadId, runId: runId, completion: completion)
                    }
                }
            case .failure(let error):
                completion(.failure(error)) // Return the error from checking status
            }
        }
    }

    private func fetchThreadMessages(
        threadID: String,
        completion: @escaping (String) -> (Void)
    ) {
        var response: String = ""
        openAI.threadsMessages(threadId: threadID) { result in
            switch result {
            case .success(let result):
                response = result.data.last?.content.last?.text?.value ?? ""
            case .failure(let error):
                response = "Network Problem"
            }
        }
        completion(response)
    }
    
    func getThreadID(for chatID: Int, completion: @escaping (String) -> Void) {
        if let threadID = storage.getThreadID(for: chatID) {
            completion(threadID)
        } else {
            let threadsQuery = ThreadsQuery(messages: [])
            
            openAI.threads(query: threadsQuery) { result in
                switch result {
                case .success(let threadResult):
                    self.storage.saveThreadID(threadResult.id, for: chatID)
                    completion(threadResult.id)
                case .failure(let error):
                    completion("")
                }
            }
        }
    }
    
    func getChatbotID(chatID: Int) -> String {
        switch chatID {
        case 0:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 1:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 2:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 3:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 4:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 5:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 6:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 7:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 8:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 9:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        case 10:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        default:
            return "asst_WY7Opu4PinGbNQ5x5jQWaovh"
        }
    }
}
