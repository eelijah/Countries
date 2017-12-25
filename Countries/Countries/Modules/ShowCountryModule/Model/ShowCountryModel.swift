//
//  ShowCountryModel.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

struct ShowCountryModel {

    struct Obtain {

        struct Request {
            let country: Country
        }

        struct Response {
            let country: Country
            let borders: [Country]
        }

        struct ViewModel {
            let name: String
            let capital: String
            let area: Measurement<UnitArea>
            let region: String
            let population: Int
            let borders: [String]
            let flag: URL
        }

    }

}

