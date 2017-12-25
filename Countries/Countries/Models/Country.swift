//
//  Country.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

struct Country: Decodable {

    let name: String
    let code: String
    let capital: String
    let borders: [String]
    let area: Double?
    let region: String
    let population: Int
    let flag: URL
    let nativeName: String

    enum CodingKeys : String, CodingKey {
        case name
        case code = "alpha3Code"
        case borders
        case capital
        case area
        case region
        case population
        case flag
        case nativeName
    }
}
