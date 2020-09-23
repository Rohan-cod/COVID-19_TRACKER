//
//  Cases.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import Foundation



struct Cases: Decodable {
    let Countries: [CountriesData]
    let Global: GlobalData
}

struct CountriesData: Decodable, Identifiable, Hashable {
    
    var id: String {
        return CountryCode
    }
    let CountryCode: String
    let Country: String
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
}

struct GlobalData: Decodable {
    
    let NewConfirmed: Int?
    let TotalConfirmed: Int?
    let NewDeaths: Int?
    let TotalDeaths: Int?
    let NewRecovered: Int?
    let TotalRecovered: Int?
}
