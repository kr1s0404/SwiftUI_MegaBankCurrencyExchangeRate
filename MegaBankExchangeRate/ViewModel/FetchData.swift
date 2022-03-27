//
//  FetchData.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 12/9/21.
//

import SwiftUI
import SwiftyJSON

class FetchData: ObservableObject
{
    @Published var datas: [ExchangeRates] = [ExchangeRates]()
    @Published var updateTime: String = ""
    
    init()
    {
        fetch()
        getUpdateTime()
    }
    
    func fetch()
    {
        let source = "https://www.megabank.com.tw/api/sc/RateExchange/Get_Fx_Currency"
        let url = URL(string: source)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            let json = try! JSON(data: data)
            
            do
            {
                for i in json["appRepBody"]["exchangeRates"]
                {
                    let currency = i.1["currency"].stringValue
                    let currencyName = i.1["currencyName"].stringValue
                    let spotExchangeRateSale = i.1["spotExchangeRate"]["sale"].stringValue
                    let spotExchangeRateBuy = i.1["spotExchangeRate"]["buy"].stringValue
                    let cashExchangeRateSale = i.1["cashExchangeRate"]["sale"].stringValue
                    let cashExchangeRateBuy = i.1["cashExchangeRate"]["buy"].stringValue
                    
                    DispatchQueue.main.async {
                        self.datas.append(ExchangeRates(id: currency, currency: currency, currencyName: currencyName, spotExchangeRateSale: spotExchangeRateSale, spotExchangeRateBuy: spotExchangeRateBuy, cashExchangeRateSale: cashExchangeRateSale, cashExchangeRateBuy: cashExchangeRateBuy))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func getUpdateTime()
    {
        let source = "https://www.megabank.com.tw/api/sc/RateExchange/Get_Fx_Currency"
        let url = URL(string: source)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            let json = try! JSON(data: data)
            
            do
            {
                let updateTime = json["appRepBody"]["updateTime"].stringValue
                
                DispatchQueue.main.async {
                    self.updateTime = updateTime
                }
            }
        }
        
        task.resume()
    }
}

