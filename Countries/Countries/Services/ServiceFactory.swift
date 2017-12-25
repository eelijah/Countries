//
//  ServiceFactory.swift
//  Countries
//
//  Created by Eli Ponkratenko on 25/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol ServiceFactory {

    func countryRepository() -> CountryRepository
    func countryApiService() -> CountryApiService

}
