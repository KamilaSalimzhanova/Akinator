import SwiftUI

struct HomeBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var frameMax: Bool = false
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Home 🏡")
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: frameMax ? .infinity : nil)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(12)
                .shadow(radius: 4)
        }
    }
}


#Preview {
    HomeBackButton()
}
