import SwiftUI

struct TitleView: View {
    @State private var appearOn = false
    @State private var degrees: Double = 0

    var body: some View {
        VStack {
            Text("Akinator".uppercased())
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundStyle(
                    LinearGradient(colors: [.yellow, .orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 4)
                .scaleEffect(1.5)
                .offset(y: 40)
                .opacity(appearOn ? 1 : 0)
                .animation(.easeOut(duration: 1.5), value: appearOn)
            Spacer()
            Image("Akinator")
                .resizable()
                .scaledToFit()
                .scaleEffect(appearOn ? 1.2 : 0.5)
                .rotation3DEffect(Angle(degrees: degrees), axis: (x: 0, y: 1, z:0))
                .shadow(color: .black, radius: 4, x: 2)
                .opacity(appearOn ? 1 : 0.3)
            
            Spacer()
        }
        .onAppear {
            withAnimation(.easeIn(duration: 2)) {
                appearOn = true
                degrees = 360
            }
        }
    }
}

#Preview {
    TitleView()
}
