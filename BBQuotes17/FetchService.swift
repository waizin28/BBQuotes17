//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/13/25.
//

import Foundation

struct FetchService{
    enum FetchError: Error {
        case badResponse
    }
    
    let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")! //convert string to URL, ! to force passed in value to convert as URL
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        // build fetch url
        let quoteUrl = baseUrl.appending(path: "quotes/random") // appending already put slash
        let fetchUrl = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        // try to fetch data from url
        
        // deal with response from server
        
        // if response good, put into quote model
        
        // return quote
    }
    
}
