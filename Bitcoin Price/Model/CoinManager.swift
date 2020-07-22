//
//  CoinManager.swift
//  Bitcoin Price
//
//  Created by Sachin Khanal on 7/22/20.
//  Copyright © 2020 Sachin Khanal. All rights reserved.
//

import Foundation
class CoinManager{
    
   
    var delegate: CoinManagerDelegate?
    let myBaseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let myKey = "your-api-key"
    
    let myCurrency = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchCoinData(for currency: String){
        
        let urlString = ("\(myBaseURL)/\(currency)?apikey=\(myKey)")
        print(urlString)
        if let myURL = URL(string: urlString){
            
            let sesson = URLSession(configuration: .default)
            let dataTask = sesson.dataTask(with: myURL){ (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJson(data: safeData){
                     let coinPrice = bitcoinPrice
                        self.delegate?.didUpdateThePrice(price: String(format:"%.2f",coinPrice), currency: currency)
                        
                    }
                }
            }
            dataTask.resume()
            
        }
        
    }
    func parseJson(data: Data)-> Double?{
        let decoder = JSONDecoder()
        do{
           let decodedData =  try decoder.decode(CoinData.self, from: data)
            let lastRate = decodedData.rate
            return lastRate
            
        }
        catch{
            print (error)
            return nil
        }
        
    }
    
}
