//
//  Splash.swift
//  yourForestReal
//
//  Created by Karsten Wennerlund on 7/2/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Splash: View {
    
    @State var isActive = false
        
    var body: some View {
        VStack{
            if isActive {
                if Auth.auth().currentUser != nil {
                    ProfileView()
                }
                else {
                    Onboarding()
                }
            }
            else{
                Text("YOUR FOREST")
            }
            
        }
        .onAppear() {
        // We move to onboarding screen after 2.5 secs
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
