import SwiftUI

struct AnswerButtonsView: View {
    @EnvironmentObject var vm: StaticGameViewModel

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                AnswerButton(title: "Yes", action: { vm.submitAnswer("Yes") })
                AnswerButton(title: "I don't know", action: { vm.submitAnswer("I don't know") })
                AnswerButton(title: "No", action: { vm.submitAnswer("No") })
            }
            HStack(spacing: 8) {
                AnswerButton(title: "Maybe Partially", action: { vm.submitAnswer("Maybe Partially") })
                AnswerButton(title: "Probably Not", action: { vm.submitAnswer("Probably Not") })
            }
        }
        .padding()
    }
}


#Preview {
    AnswerButtonsView().environmentObject(StaticGameViewModel())
}
