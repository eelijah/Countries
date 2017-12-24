//
//  CountryRepositoryImpl.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

final class CountryRepositoryImpl {

    private let countryApiService: CountryApiService
    private var countryStore: [Country]?

    init(countryApiService: CountryApiService) {
        self.countryApiService = countryApiService
    }
}

extension CountryRepositoryImpl: CountryRepository {

    func obtainCountries(completion: @escaping (Result<[Country]>) -> Void) {
        if let fetchedCountries = countryStore, !fetchedCountries.isEmpty  {
            completion(.success(fetchedCountries))
            return
        }
        countryApiService.fetchAllCountries { [weak self] result in
            if case .success(let countryList) = result {
                self?.countryStore = countryList
            }
            completion(result)
        }
    }

}
