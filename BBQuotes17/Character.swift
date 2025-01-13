//
//  Character.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/13/25.
//

import Foundation

struct Character: Decodable{
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] // can automatically convert string to url (built into string)
    let aliases: [String]
    let status: String
    let portrayedBy: String
    let death: Death? // not all character will have death data
}
