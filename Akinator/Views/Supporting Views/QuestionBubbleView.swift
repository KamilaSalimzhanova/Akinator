import SwiftUI

struct QuestionBubbleView: View {
    var questionNumber: Int = 0
    var questionText: String = "Is it female?"
    
    var body: some View {
        VStack {
            Text("Question number \(questionNumber):")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)

            Text(questionText)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

        }
        .padding()
        .background(
            SpeechBubble()
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding()
    }
}


#Preview {
    QuestionBubbleView()
}
