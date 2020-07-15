//
//  NetworkManager.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 14/07/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var cases = [CountriesData]()
    @Published var global: GlobalData?
    
    func fetchData() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Cases.self, from: safeData)
                            DispatchQueue.main.async {
                                self.cases = results.Countries
                                self.global = GlobalData(NewConfirmed: results.Global.NewConfirmed, TotalConfirmed: results.Global.TotalConfirmed, NewDeaths: results.Global.NewDeaths, TotalDeaths: results.Global.TotalDeaths, NewRecovered: results.Global.NewRecovered, TotalRecovered: results.Global.TotalRecovered)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
}
