import SwiftUI

struct SpeechBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let tailWidth: CGFloat = 20
        let tailHeight: CGFloat = 10

        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailHeight),
                            cornerSize: CGSize(width: 20, height: 20))

        path.move(to: CGPoint(x: rect.width / 2 - tailWidth / 2, y: rect.height - tailHeight))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 + tailWidth / 2, y: rect.height - tailHeight))

        return path
    }
}

#Preview {
    SpeechBubble()
}
