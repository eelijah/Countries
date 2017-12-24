//
//  CountryListAssembly.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class CountryListAssembly {

    func module() -> UIViewController {
        let interactor = CountryListInteractor(
            countryRepository: CountryRepositoryImpl(
                countryListApi: CountryListApiServiceImpl()
            )
        )
        let presenter = CountryListPresenter()
        interactor.output = presenter
        let view = CountryListViewController(nibName: nil, bundle: nil)
        view.output = interactor
        presenter.view = view
        return view
    }

}
