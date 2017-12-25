//
//  CountryListRouter.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class CountryListRouter: CommonRouter {

    weak var view: UIViewController?

    func showCountry(_ country: Country) {
        let showCountryViewController = ShowCountryModuleAssembly(serviceFactory: serviceFactory).module(for: country)
        view?.navigationController?.pushViewController(showCountryViewController, animated: true)
    }

}
