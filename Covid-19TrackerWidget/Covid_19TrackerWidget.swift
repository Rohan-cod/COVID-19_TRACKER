//
//  Covid_19TrackerWidget.swift
//  Covid-19TrackerWidget
//
//  Created by pamarori mac on 25/09/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import WidgetKit
import SwiftUI

var snapshotEntry = WidgetContent(NewConfirmed: 0, TotalConfirmed: 0, NewDeaths: 0, TotalDeaths: 0, NewRecovered: 0, TotalRecovered: 0)

struct Provider: TimelineProvider {
    
    @ObservedObject var networkManager = NetworkManager()
    
    func placeholder(in context: Context) -> WidgetContent {
        self.networkManager.fetchData()
        snapshotEntry = WidgetContent(NewConfirmed: networkManager.global?.NewConfirmed, TotalConfirmed: networkManager.global?.TotalConfirmed, NewDeaths: networkManager.global?.NewDeaths, TotalDeaths: networkManager.global?.TotalDeaths, NewRecovered: networkManager.global?.NewRecovered, TotalRecovered: networkManager.global?.TotalRecovered)
        return snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        self.networkManager.fetchData()
        snapshotEntry = WidgetContent(NewConfirmed: networkManager.global?.NewConfirmed, TotalConfirmed: networkManager.global?.TotalConfirmed, NewDeaths: networkManager.global?.NewDeaths, TotalDeaths: networkManager.global?.TotalDeaths, NewRecovered: networkManager.global?.NewRecovered, TotalRecovered: networkManager.global?.TotalRecovered)
        let entry = snapshotEntry
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [WidgetContent] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = WidgetContent(date: entryDate)
//            entries.append(entry)
//        }
        
        self.networkManager.fetchData()
        snapshotEntry = WidgetContent(NewConfirmed: networkManager.global?.NewConfirmed, TotalConfirmed: networkManager.global?.TotalConfirmed, NewDeaths: networkManager.global?.NewDeaths, TotalDeaths: networkManager.global?.TotalDeaths, NewRecovered: networkManager.global?.NewRecovered, TotalRecovered: networkManager.global?.TotalRecovered)
        
        let entries = [snapshotEntry]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}





@main
struct Covid_19TrackerWidget: Widget {
    let kind: String = "Covid_19TrackerWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            
            EntryView(model: entry)
        }
        .configurationDisplayName("Covid-19 Tracker Widget")
        .description("Widget to get latest data regarding COVID-19.")
    }
}
