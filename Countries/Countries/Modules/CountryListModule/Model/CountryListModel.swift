//
//  CountryListModel.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

struct CountryListModel {

    struct Obtain {

        struct Request {
        }

        struct Response {
            var countries: [Country]
        }

        struct ViewModel {

            struct CellViewModel {
                let name: String
                let code: String
            }

            var cellModels: [CellViewModel]
        }
    }
}
