//
//  WebService.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 29/04/22.
//

import UIKit

class WebService: NSObject {
    static let shared = WebService()

    func getWatchList(
        symbolArr: [String],
        completion: @escaping (NSDictionary?, Error?) -> Void
    ) -> Void{
        
//      let symbolArr = ["AMD","IBM","AAPL"]
      var symbolStr = ""
        for str in symbolArr {
            if symbolStr != "" {symbolStr += "%2C"}
            symbolStr += str
        }
        print(symbolStr)
//        symbolStr = "F"
        let headers = [
            "X-RapidAPI-Host": apiHost,
            "X-RapidAPI-Key": apiKey
        ]
        let url = "\(baseURL)\(marketURL)\(getQuote)?region=US&symbols=\(symbolStr)"
        Functions.urlsession(urlstr: url, method: "GET", headers: headers){ result,error in
            completion(result,error)
        }
    }
    
    func getSearchResult(
        searchString: String,
        completion: @escaping (NSDictionary?,Error?) -> Void
    ) -> Void{
        
        let headers = [
            "X-RapidAPI-Host": apiHost,
            "X-RapidAPI-Key": apiKey
        ]

        let url = "\(baseURL)\(autoComplete)?q=\(searchString)&region=US"
        print(url)
        Functions.urlsession(urlstr:url, method:"GET",headers:headers){
            result, error in
            completion(result,error)
        }
    }
    
    func getChartData(
        interval: Int,
        range: Int = 1,
        symbol: String,
        completion: @escaping (NSDictionary?, Error?) -> Void
    ) -> Void{
        let headers = [
            "X-RapidAPI-Host": apiHost,
            "X-RapidAPI-Key": apiKey
        ]
        let url = "\(baseURL)\(stockURL)\(getChart)?interval=\(interval)wk&symbol=\(symbol)&range=\(range)mo&region=US&includePrePost=false&useYfid=true&includeAdjustedClose=true&events=capitalGain%2Cdiv%2Csplit"
        print(url)
        Functions.urlsession(urlstr: url, method: "GET", headers: headers){ result, error in
            completion(result,error)
        }
    }
    
}
