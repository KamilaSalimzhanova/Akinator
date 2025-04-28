import SwiftUI

struct TextView: View {
    var text: String = ""
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(LinearGradient(colors: [.red, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.black)
            .cornerRadius(10)
    }
}

#Preview {
    TextView()
}
