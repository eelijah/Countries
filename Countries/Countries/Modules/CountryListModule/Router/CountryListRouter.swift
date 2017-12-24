//
//  CountryListRouter.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class CountryListRouter {

    weak var view: UIViewController?

    func showCountry(_ country: Country) {
        let showCountryViewController = CountryModuleAssembly().module(for: country)
        view?.navigationController?.pushViewController(showCountryViewController, animated: true)
    }

}
