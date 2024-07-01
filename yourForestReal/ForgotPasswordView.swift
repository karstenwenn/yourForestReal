//
//  ForgotPasswordView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/26/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    var body: some View {
        HStack {
            Text("Forgot Password?")
                .font(.system(size: 14))
                .foregroundStyle(Color(.purple))
        }
    }
}

#Preview {
    ForgotPasswordView()
}
