//
//  WidgetProvider.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 3/27/22.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Model
    {
        Model.fakeDate()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> ())
    {
        let loadingData = Model.fakeDate()
        completion(loadingData)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ())
    {
        getData { modelData in
            let currentDate = Date()
            let data = Model(date: currentDate, widgetData: modelData)
            
            let updateTime = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)
            let timeline = Timeline(entries: [data], policy: .after(updateTime!))
            completion(timeline)
        }
    }
}
