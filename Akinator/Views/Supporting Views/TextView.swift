import SwiftUI

struct TextView: View {
    var text: String = ""
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

#Preview {
    TextView()
}
