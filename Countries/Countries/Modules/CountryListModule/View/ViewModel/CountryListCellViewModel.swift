//
//  CountryListCellViewModel.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

final class CountryListCellViewModel {

    let name: String
    let code: String

    init(name: String, code: String) {
        self.name = name
        self.code = code
    }

}
