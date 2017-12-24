//
//  CountryModuleAssembly.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class CountryModuleAssembly {

    func module(for: Country) -> UIViewController {
        let interactor = CountryModuleInteractor()
        let presenter = CountryModulePresenter()
        let view = CountryModuleViewController(nibName: nil, bundle: nil)
        return view
    }

}
