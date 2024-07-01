//
//  RememberMeView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/26/24.
//

import SwiftUI
struct RememberMeView: View {
    @Binding var rememberLogin: Bool

    
    var body: some View {
        
        HStack {
            Toggle("Remember Me", isOn: $rememberLogin)
                .tint(.purple)
                .scaleEffect(0.6)
            .labelsHidden()
            
            Text("Remember Me")
            .font(.system(size: 14))
            
        }
    }
}

#Preview {
    RememberMeView(rememberLogin: .constant(true))
}
