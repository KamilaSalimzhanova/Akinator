
import SwiftUI

@main
struct AkinatorApp: App {
    @StateObject private var vm: StaticGameViewModel = StaticGameViewModel()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(vm)
        }
    }
}
