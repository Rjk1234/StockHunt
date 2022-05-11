//
//  GlobalConstants.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 29/04/22.
//

import UIKit

let storyboard = UIStoryboard(name: "Main", bundle: nil)
var SelectedStocks: [String] = [""]

//MARK: API functions
let apiHost: String = "yh-finance.p.rapidapi.com"
let apiKey: String = "fd21b0f2abmsh8adf3a45359b17ep1e1dbbjsn9ec0a0acb01f" //"fd21b0f2abmsh8adf3a45359b17ep1e1dbbjsn9ec0a0acb01f"// "79d4c3bf59msh5df257e20079ec3p1b14f0jsnf623f8fa4609"

let baseURL: String = "https://yh-finance.p.rapidapi.com"
let marketURL: String = "/market/v2"
let stockURL: String = "/stock/v3"
let autoComplete: String = "/auto-complete"
let getQuote: String = "/get-quotes"
let getChart: String = "/get-chart"

