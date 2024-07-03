//
//  ProfileView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/26/24.
//


import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @State private var isSignedIn = true
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            
            // if let user = viewModel.currentUser{
            Form{
                //                Section{
                //                    HStack{
                //                        Text(user.initials)
                //                            .font(.title)
                //                            .fontWeight(.semibold)
                //                            .foregroundStyle(Color(.white))
                //                            .frame(width: 72, height: 72)
                //                            .background(Color(.systemGray))
                //                            .clipShape(Circle())
                //                        VStack(alignment: .leading, spacing: 4){
                //                            Text(user.fullname)
                //                                .font(.subheadline)
                //                                .fontWeight(.semibold)
                //                                .padding(.top, 4)
                //
                //                            Text(user.email)
                //                                .font(.footnote)
                //                                .accentColor(.gray)
                //
                //                        }
                //                    }
                //                }
                Section("General"){
                    HStack{
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer ()
                        
                        Text ("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    
                }
                Section("Account"){
                    Button{
                        print("Sign out..")
                        do{
                            try Auth.auth().signOut() //signs user out on backend
                            isSignedIn = false
                        } catch {
                            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
                        }
                        
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    .navigationDestination(isPresented: $isSignedIn) {
                        LoginView()
                    }
                    Button{
                        print("Delete account..")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                }
            }
            //}
        }
    }
}

#Preview {
    ProfileView()
}
