//
//  Home.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 12/9/21.
//

import SwiftUI

struct Home: View
{
    @StateObject var viewModel = FetchData() // 在init的時候fetch過API了
    
    
    var body: some View
    {
        NavigationView
        {
            List(viewModel.datas) { currency in
                LazyVStack(alignment: .leading, spacing: 5)
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
                            Text("銀行現金買入：\(currency.cashExchangeRateBuy)")
                            Text("銀行現金賣出：\(currency.cashExchangeRateSale)")
                            Text("銀行即期買入：\(currency.spotExchangeRateBuy)")
                            Text("銀行即期賣出：\(currency.cashExchangeRateSale)")
                        }
                    }
                }
                .padding(3)
                .toolbar {
                    ToolbarItemGroup {
                        Text("更新時間：\(viewModel.updateTime)")
                            .foregroundColor(.blue.opacity(0.7))
                    }
                }
                
            }
            .navigationTitle(Text("兆豐銀行外幣匯率"))
            .refreshable {
                viewModel.fetch()
            }
        }
    }
    
    // 將貨幣名稱轉換成國旗emoji
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
    
    func stringToDate(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
}

struct Home_Previews: PreviewProvider
{
    static var previews: some View
    {
        Home()
    }
}
