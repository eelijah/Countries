//
//  ShowCountryInteractor.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol ShowCountryInteractorOutput: class {

    func didObtainResponse(response: ShowCountryModel.Obtain.Response)

}

final class ShowCountryInteractor {

    private let countryRepository: CountryRepository
    private let output: ShowCountryInteractorOutput

    init(countryRepository: CountryRepository,
         output: ShowCountryInteractorOutput) {
        self.countryRepository = countryRepository
        self.output = output
    }
    
}

extension ShowCountryInteractor: ShowCountryViewControllerOutput {

    func getCountry(request: ShowCountryModel.Obtain.Request) {
        let borders = countryRepository.getBorders(for: request.country)
        output.didObtainResponse(response:
            ShowCountryModel.Obtain.Response(
                country: request.country, borders: borders
            )
        )
    }

}
