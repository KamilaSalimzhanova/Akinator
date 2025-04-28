import SwiftUI

struct GuessCharacterView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            BackgroundView().ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    HomeBackButton(presentationMode: _presentationMode)
                        .padding(.horizontal)
                }
                Spacer()
                VStack(spacing: 12) {
                    Text("Make up real or imaginary character. I will try to guess 🤓 ")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("My guess is 0 from 0 played games")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(12)
                .shadow(radius: 8)
                .padding(.horizontal, 24)
                
                Spacer()
                
                NavigationLink {
                    GameView()
                } label: {
                    Text("Let's start!!! 🪄")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.horizontal, 64)
                }

                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GuessCharacterView()
}
