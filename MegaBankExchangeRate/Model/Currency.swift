//
//  Currency.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 12/9/21.
//

import SwiftUI

struct ExchangeRates: Codable, Identifiable, Hashable
{
    var id: String
    var currency: String
    var currencyName: String
    var updateTime: String
    let spotExchangeRateSale: String
    let spotExchangeRateBuy: String
    let cashExchangeRateSale: String
    let cashExchangeRateBuy: String
}
