//
//  CountryListApiService.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import Foundation

protocol CountryListApiService {

    func fetchCountries(completion: @escaping (Result<[Country]>) -> Void)

}

final class CountryListApiServiceImpl {

    private struct Constants {
        static let url = URL(string: "https://restcountries.eu/rest/v2/all")!
    }

}

extension CountryListApiServiceImpl: CountryListApiService {

    func fetchCountries(completion: @escaping (Result<[Country]>) -> Void) {
        let task = URLSession.shared.dataTask(with: Constants.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let countries = try decoder.decode([Country].self, from: data!)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
