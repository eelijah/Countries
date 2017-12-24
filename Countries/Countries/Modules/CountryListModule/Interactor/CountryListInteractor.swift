//
//  CountryListInteractor.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol CountryListInteractorOutput: class {
    func didObtainCountryList(_ list: [Country])
    func failedObtainCountryList(error: Error)
}

final class CountryListInteractor {

    private let countryRepository: CountryRepository
    var output: CountryListInteractorOutput?

    init(countryRepository: CountryRepository) {
        self.countryRepository = countryRepository
    }
}

extension CountryListInteractor: CountryListViewControllerOutput {

    func obtainCountriesList() {
        countryRepository.obtainCountries { [weak output] (result) in
            switch result {
            case .success(let countries):
                output?.didObtainCountryList(countries)
            case .failure(let error):
                output?.failedObtainCountryList(error: error)
            }
        }
    }

}
