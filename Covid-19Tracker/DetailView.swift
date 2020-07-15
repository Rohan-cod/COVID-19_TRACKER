//
//  DetailView.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import SwiftUI


struct DetailView: View {
    
    let cname: String
    let name: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    
    var body: some View {
        
        
        
        VStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemBackground))
                .frame(width: 300, height: 50)
                .shadow(color: Color(UIColor.label), radius: 10)
                
                .overlay(HStack {
                    Text(cname)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.5, green: 1.19, blue: 1.5))
                })
                .padding(.all)
            Spacer()
            
            Image(String(name.lowercased()))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            Spacer()
            
            
            RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.4))
            .frame(width: 400, height: 200)
            .shadow(color: Color(UIColor.label), radius: 2)
            
            
            .overlay(VStack {
                
                
                HStack {
                    Text(String("New Confirmed: " + String(newConfirmed)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.orange)
                    Spacer()
                    Text(String("Total Confirmed: " + String(totalConfirmed)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.orange)
                }.padding(.all)
                
                HStack {
                    Text(String("New Deaths: " + String(newDeaths)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                    Spacer()
                    Text(String("Total Deaths: " + String(totalDeaths)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                }.padding(.all)
                
                HStack {
                    Text(String("New Recovered: " + String(newRecovered)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.green)
                    Spacer()
                    Text(String("Total Recovered: " + String(totalRecovered)))
                        .font(.system(size: 15))
                        .foregroundColor(Color.green)
                }.padding(.all)
                
        }).padding(.all)
        }
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(cname: "India", name: "In", newConfirmed: 2, totalConfirmed: 2, newDeaths: 2, totalDeaths: 2, newRecovered: 2, totalRecovered: 2)
    }
}
