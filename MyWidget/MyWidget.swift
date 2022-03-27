//
//  MyWidget.swift
//  MyWidget
//
//  Created by Kris on 3/27/22.
//

import WidgetKit
import SwiftUI

struct MyWidgetEntryView : View
{
    var data: Model
    
    var body: some View
    {
        ForEach(data.widgetData.appRepBody.exchangeRates, id: \.self) { currency in
            VStack(alignment: .leading, spacing: 5)
            {
                HStack
                {
                    VStack
                    {
                        Text(countryFlag(currency: currency.currency))
                            .font(.system(size: 45))
                        Text(currency.currencyName)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        Text(currency.currency)
                    }
                    .padding(5)
                    
                    VStack(alignment: .leading)
                    {
                        Text("銀行現金買入：\(currency.cashExchangeRate.buy)")
                        Text("銀行現金賣出：\(currency.cashExchangeRate.sale)")
                        Text("銀行即期買入：\(currency.spotExchangeRate.buy)")
                        Text("銀行即期賣出：\(currency.spotExchangeRate.sale)")
                    }
                }
            }
            .padding(3)
        }
    }
    
    func countryFlag(currency: String) -> String
    {
        let base = 127397
        
        var flagCode = currency
        flagCode.removeLast() // 去掉最後一個字母
        
        var scalar = String.UnicodeScalarView()
        
        for i in flagCode.utf16
        {
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        return String(scalar)
    }
}
