//
//  Result.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
