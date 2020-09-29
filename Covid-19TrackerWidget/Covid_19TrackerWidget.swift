//
//  Covid_19TrackerWidget.swift
//  Covid-19TrackerWidget
//
//  Created by pamarori mac on 25/09/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import WidgetKit
import SwiftUI


struct Model: TimelineEntry {
    var date: Date
    var widgetData: Global
    
}

struct Global: Decodable {
    
    let NewConfirmed: Int?
    let TotalConfirmed: Int?
    let NewDeaths: Int?
    let TotalDeaths: Int?
    let NewRecovered: Int?
    let TotalRecovered: Int?
}


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Model {
        return Model(date: Date(), widgetData: Global(NewConfirmed: 0, TotalConfirmed: 0, NewDeaths: 0, TotalDeaths: 0, NewRecovered: 0, TotalRecovered: 0))
    }
    
    
    typealias Entry = Model
    
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> Void) {
        
        let loadingData = Model(date: Date(), widgetData: Global(NewConfirmed: 0, TotalConfirmed: 0, NewDeaths: 0, TotalDeaths: 0, NewRecovered: 0, TotalRecovered: 0))
        
        completion(loadingData)
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> Void) {
        
        getData { (modelData) in
            let date = Date()
            let data = Model(date: date, widgetData: modelData)
            
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!
            
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate))
            
            completion(timeline)
        }
        
    }
    
}



struct WidgetView: View {
    
    var data: Model
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                
                VStack {
                    Text(String("New Confirmed:"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.orange)
                    Text(String("\(data.widgetData.NewConfirmed ?? 0)"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.orange)
                }
                Spacer()
                VStack {
                    Text(String("Total Confirmed:"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.orange)
                    Text(String("\(data.widgetData.TotalConfirmed ?? 0)"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.orange)
                }
            }.padding(.all)
            
            HStack {
                VStack {
                    Text(String("New Deaths:"))
                        .font(.system(size: 12))
                
                    Text(String("\(data.widgetData.NewDeaths ?? 0)"))
                        .font(.system(size: 12))
                        
                }
                Spacer()
                VStack {
                    Text(String("Total Deaths:"))
                        .font(.system(size: 12))
                        
                    Text(String("\(data.widgetData.TotalDeaths ?? 0)"))
                        .font(.system(size: 12))
                        
                }
            }.padding(.all)
            
            HStack {
                VStack {
                    Text(String("New Recovered:"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.green)
                    Text(String("\(data.widgetData.NewRecovered ?? 0)"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.green)
                }
                Spacer()
                VStack {
                    Text(String("Total Recovered:"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.green)
                    Text(String("\(data.widgetData.TotalRecovered ?? 0)"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.green)
                }
            }.padding(.all)
            
            Spacer()
            
            
        }
        .padding()
        .cornerRadius(6)
        
        
    }
}


@main
struct MainWidget: Widget {
    let kind: String = "Covid_19TrackerWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { data in
            
            WidgetView(data: data)
        }
        .configurationDisplayName("Covid-19 Tracker Widget")
        .description("Widget to get latest data regarding COVID-19.")
    }
}


func getData(completion: @escaping (Global) -> ()) {
    if let url = URL(string: "https://api.covid19api.com/summary") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(Cases.self, from: safeData)
                        DispatchQueue.main.async {
                            let data = Global(NewConfirmed: results.Global.NewConfirmed, TotalConfirmed: results.Global.TotalConfirmed, NewDeaths: results.Global.NewDeaths, TotalDeaths: results.Global.TotalDeaths, NewRecovered: results.Global.NewRecovered, TotalRecovered: results.Global.TotalRecovered)
                            completion(data)
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
