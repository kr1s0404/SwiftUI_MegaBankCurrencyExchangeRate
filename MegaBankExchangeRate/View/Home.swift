//
//  Home.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 12/9/21.
//

import SwiftUI

struct Home: View
{
    @ObservedObject var viewModel = FetchData()
    
    
    var body: some View
    {
        NavigationView
        {
            List(viewModel.datas) { i in
                LazyVStack(alignment: .leading, spacing: 5)
                {
                    HStack
                    {
                        VStack
                        {
                            Text(countryFlag(currency: i.currency))
                                .font(.system(size: 45))
                            Text(i.currencyName)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text(i.currency)
                        }
                        .padding(5)
                        
                        VStack(alignment: .leading)
                        {
                            Text("銀行現金買入：\(i.cashExchangeRateBuy)")
                            Text("銀行現金賣出：\(i.cashExchangeRateSale)")
                            Text("銀行即期買入：\(i.spotExchangeRateBuy)")
                            Text("銀行即期賣出：\(i.cashExchangeRateSale)")
                        }
                    }
                }
                .padding(3)
                .toolbar {
                    ToolbarItemGroup {
                        Text("更新時間：\(i.updateTime)")
                            .foregroundColor(.blue.opacity(0.7))
                    }
                }
                
            }
            .refreshable {
                viewModel.fetch()
            }
            .navigationTitle(Text("兆豐銀行外幣匯率"))
            .onAppear {
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
