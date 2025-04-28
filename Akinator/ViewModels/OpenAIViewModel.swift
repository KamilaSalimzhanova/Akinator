import Foundation

final class OpenAIViewModel {
//private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    private func getOpenAIAPIKey() -> String {
            // Update the path to point to the Resources folder
            if let path = Bundle.main.path(forResource: "Resources/info", ofType: "plist"),
               let secrets = NSDictionary(contentsOfFile: path),
               let apiKey = secrets["API_KEY"] as? String {
                return apiKey
            }
            return "no foiudn"
        }


    
    func fetchOpenAIResponse(prompt: String, completion: @escaping (String) -> Void) {
        let apiKey = getOpenAIAPIKey()
        guard !apiKey.isEmpty else {
            completion("API key is missing.")
            return
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            completion("Invalid API URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": "gpt-4",
            "prompt": prompt,
            "max_tokens": 100
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            completion("Failed to encode request body.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion("Request failed: \(error.localizedDescription)")
                return
            }
            
            completion("Response received") 
        }
        
        task.resume()
    }
}
