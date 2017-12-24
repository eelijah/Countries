//
//  CountryListInteractorOutput.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

protocol CountryListInteractorOutput: class {

    func didObtainCountries(response: CountryListModel.Obtain.Response)
    func failedObtainCountryList(error: Error)

}
