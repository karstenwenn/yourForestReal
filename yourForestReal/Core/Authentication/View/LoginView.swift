//
//  LoginView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/25/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State var rememberToggle = true
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                //image
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200)
                    .padding(.vertical, 10)
                
                //form fields
                VStack(spacing: 24) {
                    InputView(text: $email,  //binding for input that we set to email
                              title: "Email Address",
                              placeholder: "email@domain.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,  //binding for input that we set to password
                              title: "Enter Your Password",
                              placeholder: "password", isSecureField: true)
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                
                //remember me and forgot your password
                HStack{
                    RememberMeView(rememberLogin: $rememberToggle)
                    Spacer()
                    ForgotPasswordView()
                }
                .padding(.horizontal)

                // sign in button
                Button {
                    print("Log user in..")
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Login")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPurple))
                
                //.disabled(formIsValid) //form validation
                //.opacity(formIsValid ? 1.0 : 0.5) //form validation
                    
                .cornerRadius(10)
                .padding(.top, 24)
                
                //"or log in with" + other options
                Text("Or Login with")
                    .padding(.top, 24)
                HStack{
                   AltLoginButtons()

                }
                
                
                // sign in platforms
                Spacer()
                
                //sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 4){
                        Text("Don't have an account?")
                            .foregroundStyle(Color.primary)
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.purple))                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol 

//extension LoginView: AuthenticationFormProtocol { //conditions for sign in
//    var formIsValid: Bool {
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//    }
//}

#Preview {
    LoginView()
}
