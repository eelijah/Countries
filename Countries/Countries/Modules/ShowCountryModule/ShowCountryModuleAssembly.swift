//
//  ShowCountryModuleAssembly.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class ShowCountryModuleAssembly: CommonAssembly {

    func module(for country: Country) -> UIViewController {
        let presenter = ShowCountryPresenter()
        let interactor = ShowCountryInteractor(
            countryRepository: serviceFactory.countryRepository(),
            output: presenter
        )
        let view = ShowCountryViewController(
            output: interactor,
            country: country
        )
        presenter.view = view
        return view
    }

}
