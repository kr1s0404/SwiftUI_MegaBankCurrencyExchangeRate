//
//  FetchData.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 3/27/22.
//

import SwiftUI

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
        } catch {
            print(error)
        }
    }
    task.resume()
}
