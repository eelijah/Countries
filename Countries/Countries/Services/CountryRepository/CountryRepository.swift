//
//  CountryRepository.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol CountryRepository {

    func obtainCountries(completion: @escaping (Result<[Country]>) -> Void)

}

final class CountryRepositoryImpl {

    private let countryListApi: CountryListApiService
    private var countryStore: [Country]?

    init(countryListApi: CountryListApiService) {
        self.countryListApi = countryListApi
    }
}

extension CountryRepositoryImpl: CountryRepository {

    func obtainCountries(completion: @escaping (Result<[Country]>) -> Void) {
        if let existedCountries = countryStore, !existedCountries.isEmpty  {
            completion(.success(existedCountries))
            return
        }
        countryListApi.fetchCountries { [weak self] result in
            if case .success(let countryList) = result {
                self?.countryStore = countryList
            }
            completion(result)
        }
    }

}
