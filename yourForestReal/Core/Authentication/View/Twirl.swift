import SwiftUI

//put this into ContentView
struct Twirl: View{
    @State private var rotateSeconds = false

    var body: some View{
        ZStack {
            CorrectButton() //the animation made in the last video
        }
        .rotationEffect(.degrees(rotateSeconds ? 360 : 0))
        .animation(Animation.easeOut(duration: 2).repeatCount(0))
         .onAppear() {
                self.rotateSeconds.toggle()
     }
    }
}

#Preview{
    Twirl()
}
