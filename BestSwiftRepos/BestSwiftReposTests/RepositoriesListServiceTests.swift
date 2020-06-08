//
//  RepositoriesListServiceTests.swift
//  BestSwiftReposTests
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import BestSwiftRepos

class RepositoriesListServiceTests: QuickSpec {

    override func spec() {
        var api: APIProviderSpy!
        var sut: RepositoriesService!
        var output: RepositoriesOutputSpy!

        func setup() {
            api = APIProviderSpy()
            output = RepositoriesOutputSpy()
            sut = RepositoriesService(api: api)
            sut.output = output
        }
        
        describe("RepositoriesListService") {
            beforeEach {
                setup()
            }
            
            describe("quando `fetchRepositories` for acionado") {
                beforeEach {
                    setup()
                    sut?.fetchRepositories()
                }
                it("então deverá chamar o serviço de busca de grupos") {
                    expect(api?.requestCalled).to(beTrue())
                    expect(api?.url).to(equal("https://api.github.com/search/repositories?q=language:swift&page=1&per_page=20"))
                }
            }
        }
    }
}

private class APIProviderSpy: Provider {
    var url: String?
    var requestCalled: Bool?
    
    func request<T>(for endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            url = try endpoint.makeUrl().absoluteString
        } catch {
            url = ""
        }
        requestCalled = true
    }
}

private class RepositoriesOutputSpy: RepositoriesOutput {
    var requestSuccededCalled: Bool?
    var requestFailedCalled: Bool?
    var repositoriesPassed: [Repository]?
    var statePassed: DataState?
    var errorPassed: APIError?

    func requestSucceded(repositories: [Repository], state: DataState) {
        requestSuccededCalled = true
        repositoriesPassed = repositories
        statePassed = state
    }
    
    func requestFailed(error: APIError) {
        requestFailedCalled = true
        errorPassed = error
    }
}
