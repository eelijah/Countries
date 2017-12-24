//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

final class CountryListViewModel {

    let cellModels: [CountryListCellViewModel]

    init(cellModels: [CountryListCellViewModel]) {
        self.cellModels = cellModels
    }

}
