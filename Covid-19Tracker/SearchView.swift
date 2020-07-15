//
//  ContentView.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search")
                List(networkManager.cases.filter {
                    self.searchText.isEmpty ? true : $0.Country.lowercased().contains(self.searchText.lowercased())
                }) { case1 in
                    
                    NavigationLink(destination: DetailView(cname: case1.Country, name: case1.CountryCode, newConfirmed: case1.NewConfirmed, totalConfirmed: case1.TotalConfirmed, newDeaths: case1.NewDeaths, totalDeaths: case1.TotalDeaths, newRecovered: case1.NewRecovered, totalRecovered: case1.TotalRecovered)) {
                        
                        HStack {
                            Image(String(case1.CountryCode.lowercased()))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 20)
                            Text(case1.Country)
                        }
                    }
                    
                }
                
            }.navigationBarTitle("COVID-19 TRACKER")
            
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
    
    
}


struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                text = ""
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            } else {
                text = searchText
            }
            
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
