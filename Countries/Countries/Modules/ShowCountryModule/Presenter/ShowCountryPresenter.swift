//
//  ShowCountryPresenter.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

final class ShowCountryPresenter {

    weak var view: ShowCountryViewControllerInput?

}

extension ShowCountryPresenter: ShowCountryInteractorOutput {

    func didObtainResponse(response: ShowCountryModel.Obtain.Response) {
        view?.showCountry(viewModel:
            ShowCountryModel.Obtain.ViewModel(
                name: response.country.name,
                capital: response.country.capital,
                area: Measurement(value: response.country.area ?? 0, unit: UnitArea.squareKilometers),
                region: response.country.region,
                population: response.country.population,
                borders: response.borders.map {
                    $0.name
                },
                flag: response.country.flag
            )
        )
    }

}
