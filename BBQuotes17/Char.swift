//
//  Character.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/13/25.
//

import Foundation

// character data model
struct Char: Decodable{
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] // can automatically convert string to url (built into string)
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death? // not all character will have death data (this is var because optional automatically set its value to nil)
    
    // noting list of properties going to look for at json data
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
        case death
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase // convert snake case at json data to camel case
        
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!) //can remove ! after try because there is throws in method
        death = try deathDecoder.decode(Death.self, from: deathData)
    }
}
