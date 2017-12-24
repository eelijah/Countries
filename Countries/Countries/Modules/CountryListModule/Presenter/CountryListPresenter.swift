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

    func didObtainCountryList(_ list: [Country]) {
        var cellViewModels = [CountryListCellViewModel]()
        list.forEach { country in
            cellViewModels.append(
                CountryListCellViewModel(
                    name: country.name,
                    code: country.code
                )
            )
        }
        DispatchQueue.main.async { [weak view] in
            view?.showCountryList(with:
                CountryListViewModel(cellModels: cellViewModels)
            )
        }
    }

    func failedObtainCountryList(error: Error) {
        DispatchQueue.main.async { [weak view] in
            view?.showErrorAlert(message: error.localizedDescription)
        }
    }

}
