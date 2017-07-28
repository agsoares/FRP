//
//  GithubAPI.swift
//  Functional
//
//  Created by Adriano Soares on 23/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import Moya
import ReactiveSwift
import ReactiveMoya
import ObjectMapper

enum GithubService {
    case getUser(username: String)
    case getRepos(username: String)

}

extension GithubService: TargetType {
    var headers: [String : String]? {
        return nil
    }

    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .getUser(let username):
            return "/users/\(username)"
        case .getRepos(let username):
            return "/users/\(username)/repos"
        }

    }
    var method: Moya.Method {
        switch self {
        case .getUser, .getRepos:
            return .get

        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getUser, .getRepos:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getUser, .getRepos:
            return URLEncoding.default // Send parameters in URL for GET, DELETE and HEAD. For other HTTP methods, parameters will be sent in request body
        }
    }
    var sampleData: Data {
        return Data()

    }
    var task: Task {
        switch self {
        case .getUser, .getRepos:
            return .request
        }
    }
}


class GithubAPI: NSObject {
    let provider   = ReactiveSwiftMoyaProvider<GithubService>()

    func getRepos(username: String) -> MutableProperty<[RepoModel]> {
        let result = MutableProperty<[RepoModel]>([])
        provider.request(.getRepos(username: username)).start { event in
            switch event {
            case .value(let response):
                do {
                    if let repos = Mapper<RepoModel>().mapArray(JSONObject: try response.mapJSON()) {
                        result.value = repos
                    }
                } catch {
                    print("parsing error")
                }

            case .failed(let error):
                print (error.localizedDescription)
            default:
                break
            }
        }


        return result
    }

}

