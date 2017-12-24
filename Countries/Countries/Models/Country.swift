//
//  Country.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

struct Country: Decodable {

    let name: String
    let code: String
    let borders: [String]
    let population: Int
    let capital: String
    let area: Double?

    enum CodingKeys : String, CodingKey {
        case name
        case code = "alpha3Code"
        case borders
        case population
        case capital
        case area
    }
}
