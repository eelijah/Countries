//
//  CountryListPresenter.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

final class CountryListPresenter {

    weak var view: CountryListViewControllerInput?

}

extension CountryListPresenter: CountryListInteractorOutput {

    func didObtainCountries(response: CountryListModel.Obtain.Response) {
        let cellModels = response.countries.map { country in
            return CountryListModel.Obtain.ViewModel.CellViewModel(
                name: country.name,
                code: country.code
            )
        }
        DispatchQueue.main.async { [weak view] in
            view?.showCountries(
                viewModel: CountryListModel.Obtain.ViewModel(
                    cellModels: cellModels
                )
            )
        }
    }

    func failedObtainCountryList(error: Error) {
        DispatchQueue.main.async { [weak view] in
            view?.showErrorAlert(message: error.localizedDescription)
        }
    }

}
