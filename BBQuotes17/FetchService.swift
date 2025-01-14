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
    // Get random quote from a specific show
    func fetchQuote(from show: String) async throws -> Quote {
        // build fetch url
        let quoteUrl = baseUrl.appending(path: "quotes/random") // appending already put slash
        let fetchUrl = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // try to fetch data from url
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        // deal with response from server
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw FetchError.badResponse
        }
            
        // decode data, if response good, put into quote model
        let quote = try JSONDecoder().decode(Quote.self, from: data) // why self? -> represent theme version otherwise it will be type itself
        
        // return quote
        return quote
    }
    
    // Get information about a chracter
    func fetchCharacter(_ name: String) async throws -> Character {
        // build fetch url
        let characterUrl = baseUrl.appending(path: "characters")
        let fetchUrl = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        // try to fetch data from url
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        // deal with response from server
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // decode data, put into character model (Have to deal with snake case to camel case)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data) //reason to decode as array is because we are given back array
        
        return characters[0]
    }
    
    // Get information about death related to a character
    func fetchDeath(for character: String) async throws -> Death? { // return death or nil
        
        // construct fetch url
        let fetchUrl = baseUrl.appending(path: "deaths")
        
        // request from api
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        // deal with response from server
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths{
            if death.character == character{
                return death
            }
        }
        
        return nil
    }
    
}
