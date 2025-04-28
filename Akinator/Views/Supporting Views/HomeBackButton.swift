import SwiftUI

struct HomeBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Home 🏡")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }
            .padding()
        }
    }
}

#Preview {
    HomeBackButton()
}
