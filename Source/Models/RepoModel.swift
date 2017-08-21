//
//  RepoModel.swift
//  Functional
//
//  Created by Adriano Soares on 25/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import ObjectMapper

class RepoModel: Mappable {
    var fullName: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        fullName <- map["full_name"]
    }

}
