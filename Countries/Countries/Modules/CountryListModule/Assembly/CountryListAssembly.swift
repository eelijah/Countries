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
        let presenter = CountryListPresenter()
        let interactor = CountryListInteractor(
            countryRepository: CountryRepositoryImpl(
                countryApiService: CountryApiServiceImpl()
            ),
            output: presenter
        )
        let router = CountryListRouter()
        let view = CountryListViewController(
            router: router,
            output: interactor
        )
        router.view = view
        presenter.view = view
        return view
    }

}
