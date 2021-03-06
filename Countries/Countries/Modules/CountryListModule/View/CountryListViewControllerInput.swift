//
//  CountryListViewControllerInput.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol CountryListViewControllerInput: class {

    func showCountries(viewModel: CountryListModel.Obtain.ViewModel)
    func showErrorAlert(message: String)
    
}
