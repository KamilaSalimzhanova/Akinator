import Foundation
import SwiftUI

class OpenAIViewModel: ObservableObject {
    @Published var resultText: String = "Thinking about your character..."
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    
    func fetchOpenAIResponse(prompt: String) {
        guard !apiKey.isEmpty else {
            self.errorMessage = "API key is missing."
            return
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            self.errorMessage = "Invalid API URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "prompt": prompt,
            "max_tokens": 100
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode request body."
            return
        }
        
        isLoading = true
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = "Request failed: \(error.localizedDescription)"
                    self?.isLoading = false
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.errorMessage = "No data received from the server."
                    self?.isLoading = false
                }
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.resultText = jsonResponse.choices.first?.text ?? "No response text"
                    self?.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode response."
                    self?.isLoading = false
                }
            }
        }
        
        task.resume()
    }
}
