//
//  CountryRepositoryImpl.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

final class CountryRepositoryImpl {

    private let countryApiService: CountryApiService
    private var countryStore = [String: Country]()

    init(countryApiService: CountryApiService) {
        self.countryApiService = countryApiService
    }
}

extension CountryRepositoryImpl: CountryRepository {

    func obtainCountries(completion: @escaping (Result<[Country]>) -> Void) {
        let storedCountries = countryStore.values
        if !storedCountries.isEmpty  {
            completion(.success(Array(storedCountries)))
            return
        }
        countryApiService.fetchAllCountries { [weak self] result in
            if case .success(let countryList) = result {
                countryList.forEach { country in
                    self?.countryStore[country.code] = country
                }
            }
            completion(result)
        }
    }

    func getBorders(for country: Country) -> [Country] {
        return countryStore.flatMap { (key, value) in
            guard country.code == key else {
                return nil
            }
            return value
        }
    }

}
