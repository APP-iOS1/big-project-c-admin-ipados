//
//  ContentView.swift
//  big-project-c-admin-ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection: Int = 2
    var body: some View {
        
        
        
        TabView(selection: $tabSelection, content: {
            EmptyDetailView()
                .tabItem {
                    Label("현황", systemImage: "chart.pie.fill")
                }
                .tag(1)
            
            GeneralView()
                .tabItem {
                    Label("세션", systemImage: "list.bullet")
                }
                .tag(2)
            
            GeneralView()
                .tabItem {
                    Label("회원", systemImage: "person.2.fill")
                }
                .tag(3)
 
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
