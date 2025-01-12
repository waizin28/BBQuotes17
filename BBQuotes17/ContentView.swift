//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar) // to make tab differentator appear
                .tabItem{
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar) // to make tab differentator appear
                .tabItem{
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
