import Foundation

protocol DataStorageProtocol: AnyObject {
    func getThreadID(for chatID: Int) -> String?
    func saveThreadID(_ threadID: String, for chatID: Int)
}

final class DataStorage: DataStorageProtocol {
    
    // MARK: - Thread ID
    func getThreadID(for chatID: Int) -> String? {
        return UserDefaults.standard.string(forKey: String(chatID))
    }
    
    func saveThreadID(_ threadID: String, for chatID: Int) {
        UserDefaults.standard.setValue(threadID, forKey: String(chatID))
    }
}
