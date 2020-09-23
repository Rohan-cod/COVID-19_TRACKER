//
//  HomeView.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
                .frame(width: 300, height: 50)
                .shadow(color: Color(UIColor.label), radius: 10)
                
                .overlay(HStack {
                    Text("COVID-19 TRACKER")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.5, green: 1.19, blue: 1.5))
                })
                .padding(.all)
            Spacer()
            Image("Earth")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 400, height: 200)
                .shadow(color: Color(UIColor.label), radius: 7)
                
                
                .overlay(VStack {
                    
                    HStack {
                        Text(String("New Confirmed: \(networkManager.global?.NewConfirmed ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.orange)
                        Spacer()
                        Text(String("Total Confirmed: \(networkManager.global?.TotalConfirmed ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.orange)
                    }.padding(.all)
                    
                    HStack {
                        Text(String("New Deaths: \(networkManager.global?.NewDeaths ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                        Spacer()
                        Text(String("Total Deaths: \(networkManager.global?.TotalDeaths ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                    }.padding(.all)
                    
                    HStack {
                        Text(String("New Recovered: \(networkManager.global?.NewRecovered ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.green)
                        Spacer()
                        Text(String("Total Recovered: \(networkManager.global?.TotalRecovered ?? 0)"))
                            .font(.system(size: 15))
                            .foregroundColor(Color.green)
                    }.padding(.all)
                    
                })
                .padding(.all)
            
            Spacer()
            HStack {
                Text("Data From Postman API")
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Image(systemName: "arrow.up.right.square")
                })
            }
            .padding()
            
            
        }
            
        .onAppear {
            self.networkManager.fetchData()
        }
        .sheet(isPresented: self.$isPresented, content: {
            WebView(urlString: "https://covid-19-apis.postman.com")
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
