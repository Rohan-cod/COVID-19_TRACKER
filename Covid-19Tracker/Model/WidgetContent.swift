//
//  WidgetContent.swift
//  Covid-19Tracker
//
//  Created by pamarori mac on 25/09/20.
//  Copyright © 2020 pamarori mac. All rights reserved.
//

import Foundation
import WidgetKit



struct WidgetContent: TimelineEntry {
    var date = Date()
    let NewConfirmed: Int?
    let TotalConfirmed: Int?
    let NewDeaths: Int?
    let TotalDeaths: Int?
    let NewRecovered: Int?
    let TotalRecovered: Int?
    
}
