//
//  WelcomeView.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
        HomeView()
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
        SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
