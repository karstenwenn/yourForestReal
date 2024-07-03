////
////  yourForestRealApp.swift
////  yourForestReal
////
////  Created by Karsten Wennerlund on 7/1/24.
////
//
//import SwiftUI
//
//@main
//struct yourForestRealApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        Splash()
      }
    }
  }
}







//import SwiftUI
//import FirebaseCore
////@main
////struct yf_layoutApp: App {
////    var body: some Scene {
////        WindowGroup {
////            ContentViewForNavigation()
////        }
////    }
////}
//
//@main
//struct yf_layoutApp: App {
//    init() {
//        FirebaseApp.configure()
//    }
//    
//    @StateObject var viewModel = AuthViewModel()
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//                .environmentObject(viewModel)
//        }
//    }
//}
//
//
//
//
