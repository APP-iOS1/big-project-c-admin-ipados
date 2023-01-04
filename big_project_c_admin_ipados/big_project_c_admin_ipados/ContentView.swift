//
//  ContentView.swift
//  big-project-c-admin-ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel : UserStore
    
    @State private var tabSelection: Int = 2
    var body: some View {
        if userViewModel.currentUser != nil {
            TabView(selection: $tabSelection, content: {
                DashBoardView(slices: [
                    (3, .orange),
                    (1, .gray)
                ])

                    .tabItem {
                        Label("현황", systemImage: "chart.pie.fill")
                    }
                    .tag(1)

                GeneralView()
                    .tabItem {
                        Label("세션", systemImage: "list.bullet")
                    }
                    .tag(2)

                MemberListView()
                    .tabItem {
                        Label("회원", systemImage: "person.2.fill")
                    }
                    .tag(3)

            })
        } else {
            LoginView()
        }
//                    NavigationView {
//                        if userViewModel.isLogin == true {
//                            TabView(selection: $tabSelection, content: {
//                                EmptyDetailView()
//                                    .tabItem {
//                                        Label("현황", systemImage: "chart.pie.fill")
//                                    }
//                                    .tag(1)
//
//                                GeneralView()
//                                    .tabItem {
//                                        Label("세션", systemImage: "list.bullet")
//                                    }
//                                    .tag(2)
//
//                                GeneralView()
//                                    .tabItem {
//                                        Label("회원", systemImage: "person.2.fill")
//                                    }
//                                    .tag(3)
//
//                            })
//                        }
//                        else {
//                            LoginView()
//                        }
//                    }
//                    .onAppear {
//                        if userViewModel.currentUser != nil {
//                            userViewModel.isLogin = true
//                            userUID = userViewModel.currentUser?.uid ?? ""
//                        }
//                    }
        
        
        
//            .onAppear {
//                if userViewModel.currentUser != nil {
//                    userViewModel.isLogin = true
//                    userUID = userViewModel.currentUser?.uid ?? ""
//                }
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
