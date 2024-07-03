//
//  RegistrationView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/26/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword  = ""
    
    @State private var isLoading = false
    @State var isSignedIn = false

    
    @Environment(\.dismiss) var dismiss //useful for popping back to the oriignal screen via button below
    //@EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
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
                
                InputView(text: $fullname,  //binding for input that we set to email
                          title: "Full Name",
                          placeholder: "Enter your name")
                
                InputView(text: $password,  //binding for input that we set to password
                          title: "Enter your Password",
                          placeholder: "password", isSecureField: true)
                .autocapitalization(.none)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,  //binding for input that we set to password
                              title: "Confirm Password",
                              placeholder: "Confirm your Password", isSecureField: true)
                    .autocapitalization(.none)
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Button {
                print("Sign user up..")
//                Task{
//                    try await viewModel.createUser(withEmail: email,
//                                                   password: password,
//                                                   fullname: fullname)
//                }
                isLoading.toggle()
                Auth.auth().createUser(withEmail: email, password: password) { ( result, error) in
                    isLoading.toggle()
                    
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        withAnimation{
                            isLoading.toggle()
                        }
                    }
                    else {
                        //colect user information
                        let db = Firestore.firestore()
                        let data: [String: Any] = ["Full Name": fullname, "Email": email]
                        // Now we add same user name and email to local memory so we don't need to sync every
                        
                        UserDefaults.standard.setValue(result?.user.uid, forKey: "UID")
                        // UID is unique key provided to user when they sign up to firestore database
                        UserDefaults.standard.setValue(fullname, forKey: "NAME")
                        
                        UserDefaults.standard.setValue(email, forKey: "EMAIL")
                        db.collection("USERS").addDocument(data: data)
                        isLoading.toggle()
                        isSignedIn = true
                    }
                }
            } label: {
//                CorrectButton()
                HStack {
                    if isLoading {
                        ProgressView()
                    }
                    else {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .navigationDestination(isPresented: $isSignedIn) {
                   ProfileView()
                }
            }
            .background(Color(.systemPurple))
            
            //.disabled(formIsValid) //form validation
            //.opacity(formIsValid ? 1.0 : 0.5) //form validation
            
            .cornerRadius(10)
            .padding(.top, 24)

            Spacer()
            
            Button {
                dismiss() //calls the dismiss function to pop back to prior login page as that is where the navigation stack is
            } label: {
                HStack(spacing: 4){
                    Text("Already have an account?")
                        .foregroundStyle(Color(.black))
                    Text("Sign in")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.purple))                    }
                .font(.system(size: 14))
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol for registration page

//extension RegistrationView: AuthenticationFormProtocol { //conditions for sign in
//    var formIsValid: Bool {
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//        && !fullname.isEmpty
//        && confirmPassword == password
//    }
//}

#Preview {
    RegistrationView()
}
