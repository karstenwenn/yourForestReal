//
//  button.swift
//  yourForestReal
//
//  Created by Karsten Wennerlund on 7/2/24.
//

import SwiftUI

struct CorrectButton: View {
    
    @State var tap = false
    @State var press = false
    @State var alterState = false
    
    var body: some View {
        ZStack {
            Circle() //outer ring flash after pressed
                .stroke(lineWidth: alterState ? 20 : 0)
                .frame(width: alterState ? 500 : 0, height: alterState ? 500 : 0)
                .foregroundColor(Color(#colorLiteral(red: 0.49200207, green: 1, blue: 0.4950069785, alpha: 1)))
                .blur(radius: alterState ? 5 : 20)
                .opacity(alterState ? 0 : 1)
            Text("correct")
                .font(.system(size: 20, weight: .semibold, design: .rounded)).foregroundColor( alterState ? Color.clear : (tap ? Color(#colorLiteral(red: 0.4931054115, green: 0.6306983232, blue: 1, alpha: 1)): Color(#colorLiteral(red: 0.4657435417, green: 0.5916289687, blue: 0.9575648904, alpha: 0.8119689388))))
                .frame(width: 200, height: alterState ? 200 : 60) //changes the width to make a circle shape when fully pressed
                    .background(
                        ZStack{
                            Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                            RoundedRectangle(cornerRadius: alterState ? 100 : 16, style: .continuous) //adds button depth by additional rounded that rectangle that is offset, get rid of foreground color & blur to understand
                                .foregroundColor(.white)
                                .blur(radius: 3)
                                .offset(x: -2, y: -2)
                            RoundedRectangle(cornerRadius: alterState ? 100 : 16, style: .continuous)
                                .fill( alterState ? //chooses between where to put the lighting/color movement on button surface based on pressed
                                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7411747575, green: 0.9638548493, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.49200207, green: 1, blue: 0.4950069785, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        :
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9194613099, green: 0.941408515, blue: 1, alpha: 0.75)), Color.white]), startPoint: tap ? .top : .topTrailing, endPoint: tap ? .bottom : .bottomLeading)
                                    )
                                .padding(2)
                                .blur(radius: 3)
                                .offset(x: 3, y: 3)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: alterState ? 100 : 16, style: .continuous)) //rounded cut out to give impression of button shape
                .shadow(color: press ? Color(#colorLiteral(red: 0.4931054115, green: 0.6306983232, blue: 1, alpha: 1)) : Color.clear, radius: 9, x: 0, y: 0) //blue glow that shows up when fully pressed
                .shadow(color: press ? Color.clear : (tap ?               Color(#colorLiteral(red: 0.4132584929, green: 0.4436882138, blue: 0.5055162311, alpha: 0.7532925793)) : Color(#colorLiteral(red: 0.6476906538, green: 0.6953927875, blue: 0.7922747135, alpha: 0.5097243202))), radius: tap ? 5:10, x:tap ? 1:20, y:tap ? 1:20) //y pos and x pos and radius of shadow and where it moves to when it is tapped on //shadow behind the button
                .scaleEffect( alterState ? 0 : (tap ? 0.9 : 1)) //0.9 is the size it moves to when tapped fully
                
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged{_ in
                            if self.press == true { self.press = false}
                            self.tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if self.tap == true {
                                    self.press = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.alterState = true
                                        //self.alterState.toggle()
                                    }
                                }
                            }
                        }
                        .onEnded{ _ in
                            if self.press == false { self.tap = false }
                        }
                )
                .opacity(alterState ? 0 : 0.9) //hides button if fully pressed



        }
//        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        .statusBar(hidden: true)
    }
}


#Preview {
    CorrectButton()
}
