import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.orange, .purple, .red, .pink], startPoint: .top, endPoint: .bottom)
        RadialGradient(colors: [.purple.opacity(0.5), .red.opacity(0.5), .green.opacity(0.8), .blue.opacity(0.4), .green.opacity(0.4)], center: .center, startRadius: 360, endRadius: 0)
    }
}

#Preview {
    BackgroundView()
}
