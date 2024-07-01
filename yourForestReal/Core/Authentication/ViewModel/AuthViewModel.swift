//
//  AuthViewModel.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/26/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

//protocol AuthenticationFormProtocol {
//    var formIsValid: Bool { get }
//} //used to create protocol that is able to assess if the user has suffecient entry in the input view areas, see login view

@MainActor

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? //tell us whether or not we have a user logged in
    @Published var currentUser: User? //the fire base version
    
    init() {
       // if(rememberToggle){
            self.userSession = Auth.auth().currentUser //this stores the info locally on the device is there is account
        Task{
            await fetchUser() //fetches user data right away
        }
            
       
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        //print("sign in.. ")
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser() 
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async  throws { //async function that will throw error if wrong
        //print("create user.. ")
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password:  password) //create a user using firebase code and store in prop
            self.userSession = result.user //if we get the result, store it in userSession
            let user = User(id: result.user.uid, fullname: fullname, email: email) //now, we create our own user object
            let encodedUser = try Firestore.Encoder().encode(user) //encode our object through the encodable prodocal
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) //upload that data to firestore
            await fetchUser() // we need to fetch the data we just sent to firebase in order to display it on screen. 
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut() //signs user out on backend
            self.userSession = nil //wipes out user session and takes us back to login screen -> our scene logic will show login view
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {

    }
    
    func fetchUser() async { //this is decoding: we take incoming raw data (json data) and map it into a data object
        
        //firebase works with raw data no objects
        guard let uid = Auth.auth().currentUser?.uid else { return } //if there is this info it will keep going but otherwise it will stop and not waste an API call
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
        //print("DEBUG: Current user is \(self.currentUser)")
    }
}
