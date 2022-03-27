//
//  WidgetModel.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 3/27/22.
//

import SwiftUI
import WidgetKit

struct Model: TimelineEntry {
    let date: Date
    var widgetData: appRepBody
    
    static func fakeDate() -> Model
    {
        return Model(date: Date(), widgetData: appRepBody(appRepBody: exchangeRates(exchangeRates: Array(repeating: JsonModel(currency: "123", currencyName: "123", spotExchangeRate: Price(sale: "", buy: ""), cashExchangeRate: Price(sale: "", buy: "")), count: 1))))
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
