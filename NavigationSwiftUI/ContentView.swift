//
//  ContentView.swift
//  NavigationSwiftUI
//
//  Created by Meezu Lawot on 24/09/2023.
//

import SwiftUI

class SessionManager: ObservableObject {

    var goToRootView: Bool = false{
        didSet{
            if goToRootView{
                rootId = UUID()
            }
        }
    }
    
    @Published
    var rootId: UUID = UUID()
    
}


struct RootView: View {
    @EnvironmentObject private var sessionManager: SessionManager
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            
            TabView(selection: $selectedTab) {
                HomeView()
                    .navigationTitle("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                FundTransfer()
                    .navigationTitle("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Fund Transfer")
                    }
                    .tag(1)
            }
            .onAppear{
                selectedTab = 0
            }
            
//            VStack{
//                Text("Root View")
//                NavigationLink("GO to Home", destination: HomeView().environmentObject(sessionManager))
//            }
                        
        }.id(sessionManager.rootId)
            .onAppear {
                if sessionManager.goToRootView {
                    sessionManager.goToRootView = false // Reset the flag
                }
            }
    }
}


struct HomeView: View {
    @EnvironmentObject private var sessionManager: SessionManager
    
    var body: some View {
        
        VStack{
            NavigationLink("Go to FundTransfer", destination: FundTransfer())
        }
    }
}


struct FundTransfer: View {
    
    @EnvironmentObject private var sessionManager: SessionManager
    
    var body: some View {
        ZStack{
            NavigationLink("Go to ConfirmView", destination: ConfirmView())
        }
    }
}

struct ConfirmView: View {
    
    @EnvironmentObject private var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            NavigationLink("Go to PrepareView", destination: PrepareView())
            
            Button("Back to FundTransfer") {
                        presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct PrepareView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack{
            Button(action: {
                sessionManager.goToRootView = true
                
            }, label: {
                Text("Pop to RootView")
            })
        }
    }
        
        
}


//struct ContentViewFour: View {
//    @EnvironmentObject
//    var sessionManager: SessionManager
//
//    var body: some View {
//        Button(action: {
//            sessionManager.isLoggedIn.toggle()
//        }, label: {
//            Text("logout")
//        })
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
