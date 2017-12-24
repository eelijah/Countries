//
//  CountryListInteractor.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

final class CountryListInteractor {

    private let countryRepository: CountryRepository
    private var output: CountryListInteractorOutput?

    init(countryRepository: CountryRepository,
         output: CountryListInteractorOutput) {
        self.countryRepository = countryRepository
        self.output = output
    }
}

extension CountryListInteractor: CountryListViewControllerOutput {

    func obtainCountriesList(request: CountryListModel.Obtain.Request) {
        countryRepository.obtainCountries { [weak output] (result) in
            switch result {
            case .success(let countries):
                output?.didObtainCountries(
                    response: CountryListModel.Obtain.Response(
                        countries: countries
                    )
                )
            case .failure(let error):
                output?.failedObtainCountryList(error: error)
            }
        }
    }

}
