//
//  CountryApiService.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol CountryApiService {

    func fetchAllCountries(completion: @escaping (Result<[Country]>) -> Void)

}
