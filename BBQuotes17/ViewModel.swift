//
//  ViewModel.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/14/25.
//

import Foundation

// ViewModel is observable to the view (more initmiate connection to the view), view treats ViewModel's properties as its own properties

@Observable // every single property inside view model would be like state property on view
@MainActor // UI run on main actor and since we need to associate with UI to be in sync with view
class ViewModel{ // class need inital value if we declare property
    
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    // property to track fetch status
    private(set) var status: FetchStatus = .notStarted // private(set) can get but not set
    
    // initialize fetch service and get data
    private let fetcher = FetchService()
    
    // store data
    var quote: Quote
    var chracter: Char
    
    // run as soon as we initilize this class
    init(){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // convert snake case at json data to camel case
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!) //need ! because we don't have do catch here
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!) //need ! because we don't have do catch here
        chracter = try! decoder.decode(Char.self, from: characterData)
    }
}
