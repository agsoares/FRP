//
//  MainViewModel.swift
//  Functional
//
//  Created by Adriano Soares on 23/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import ReactiveSwift
import Moya

class MainViewModel: NSObject {
    let searchText = MutableProperty<String?>(nil)
    let repos      = MutableProperty<[RepoModel]> ([])
    let user       = MutableProperty<UserModel?>(nil)

    override init() {
        super.init()
        searchText.signal.delay(0.5, on: QueueScheduler.main).skipNil().observeValues { [weak self] text in
            GithubAPI().getUser(username: text).signal.observeValues { user in
                self?.user.value = user
            }

            GithubAPI().getRepos(username: text).signal.observeValues { repos in
                self?.repos.value = repos
            }
        }
    }

}
