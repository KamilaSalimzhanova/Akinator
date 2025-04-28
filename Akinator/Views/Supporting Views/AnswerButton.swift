import SwiftUI

struct AnswerButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 44) 
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.yellow.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
        }
    }
}

#Preview {
    AnswerButton(title: "Yes", action: {})
}
