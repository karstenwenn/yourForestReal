//
//  ActualContentView.swift
//  yf-layout
//
//  Created by Karsten Wennerlund on 6/25/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
                //HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}

//struct SheetView: View {
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        Button("Press to dismiss") {
//            dismiss()
//        }
//        .font(.title)
//        .padding()
//        .background(.black)
//    }
//}
//
//struct MainView: View {
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SheetView()
//        }
//    }
//}
