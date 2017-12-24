//
//  ShowCountryModuleAssembly.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class ShowCountryModuleAssembly {

    func module(for: Country) -> UIViewController {
        let interactor = ShowCountryInteractor()
        let presenter = ShowCountryPresenter()
        let view = ShowCountryViewController(nibName: nil, bundle: nil)
        return view
    }

}
