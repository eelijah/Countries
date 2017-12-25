//
//  ServiceFactoryImpl.swift
//  Countries
//
//  Created by Eli Ponkratenko on 25/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

final class ServiceFactoryImpl {

    private lazy var _countryRepository: CountryRepository = {
        return CountryRepositoryImpl(
            countryApiService: self.countryApiService()
        )
    }()

}

extension ServiceFactoryImpl: ServiceFactory {

    func countryRepository() -> CountryRepository {
        return _countryRepository
    }

    func countryApiService() -> CountryApiService {
        return CountryApiServiceImpl()
    }

}
