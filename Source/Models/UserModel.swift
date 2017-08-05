//
//  UserModel.swift
//  Functional
//
//  Created by Adriano Soares on 05/08/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {
    var fullName: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.fullName <- map["full_name"]
    }
}
