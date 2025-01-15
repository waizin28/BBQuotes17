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
            Tab("Breaking Bad", systemImage: "tortoise"){
                QuoteView(show: "Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar) // to make tab differentator appear
            }
            
            Tab("Better Call Saul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar) // to make tab differentator appear
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
