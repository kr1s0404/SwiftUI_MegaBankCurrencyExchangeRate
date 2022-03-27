//
//  MyWidget.swift
//  MyWidget
//
//  Created by Kris on 3/27/22.
//

import WidgetKit
import SwiftUI

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

struct Model: TimelineEntry {
    let date: Date
    var widgetData: appRepBody
    
    static func fakeDate() -> Model
    {
        return Model(date: Date(), widgetData: appRepBody(appRepBody: exchangeRates(exchangeRates: Array(repeating: JsonModel(currency: "123", currencyName: "123", spotExchangeRate: Price(sale: "", buy: ""), cashExchangeRate: Price(sale: "", buy: "")), count: 5))))
    }
}

struct appRepBody: Decodable, Hashable
{
    var appRepBody: exchangeRates
}

struct exchangeRates: Decodable, Hashable
{
    var exchangeRates: [JsonModel]
}

struct JsonModel: Decodable, Hashable
{
    var currency: String
    var currencyName: String
    var spotExchangeRate: Price
    var cashExchangeRate: Price
}

struct Price: Decodable, Hashable
{
    var sale: String
    var buy: String
}

struct MyWidgetEntryView : View
{
    
    var data: Model
    
    var body: some View
    {
        VStack()
        {
            
            Text("Test")
                .font(.title)
                .foregroundColor(.red)
            
            ForEach(data.widgetData.appRepBody.exchangeRates, id: \.self) { currency in
                Text(currency.currencyName)
            }
        }
    }
}

func getData(completion: @escaping (appRepBody) -> ())
{
    let source = "https://www.megabank.com.tw/api/sc/RateExchange/Get_Fx_Currency"
    let url = URL(string: source)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        guard let data = data, error == nil else { return }
        
        do {
            
            let jsonData = try JSONDecoder().decode(appRepBody.self, from: data)
            completion(jsonData)
            print(jsonData)
            
        } catch {
            print(error)
        }
        
    }
    task.resume()
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(data: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

//struct MyWidget_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        MyWidgetEntryView(data: Model.fakeDate())
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
