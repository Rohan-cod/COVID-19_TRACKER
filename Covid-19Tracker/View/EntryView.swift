//
//  EntryView.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 25/09/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    
    var model: WidgetContent
    

    var body: some View {
        VStack {
            
            HStack {
                Text(String("New Confirmed: \(model.NewConfirmed ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.orange)
                Spacer()
                Text(String("Total Confirmed: \(model.TotalConfirmed ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.orange)
            }.padding(.all)
            
            HStack {
                Text(String("New Deaths: \(model.NewDeaths ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.white)
                Spacer()
                Text(String("Total Deaths: \(model.TotalDeaths ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.white)
            }.padding(.all)
            
            HStack {
                Text(String("New Recovered: \(model.NewRecovered ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.green)
                Spacer()
                Text(String("Total Recovered: \(model.TotalRecovered ?? 0)"))
                    .font(.system(size: 15))
                    .foregroundColor(Color.green)
            }.padding(.all)
            
        }
        .padding()
        .cornerRadius(6)
    }
}
