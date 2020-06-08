//
//  BestSwiftReposTests.swift
//  BestSwiftReposTests
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import BestSwiftRepos

class RepositoriesListPresenterTests: QuickSpec {
    
    override func spec() {
        var service: RepositoriesInputSpy!
        var view: RepositoriesViewSpy!
        var repositoriesListPresenter: RepositoriesListPresenter!
        
        func setup(repositoriesList: Repository = .dummyRepositoryResponse) {
            service = RepositoriesInputSpy()
            view = RepositoriesViewSpy()
            repositoriesListPresenter = RepositoriesListPresenter(service: service)
        }
        
        describe("RepositoriesListPresenter") {
            
            beforeEach {
                setup()
            }
            
            describe("quando for instanciado") {
                beforeEach {
                    setup()
                }
                it("então deverá atribuir o output do serviço") {
                    expect(service.output).to(beIdenticalTo(repositoriesListPresenter))
                }
            }
            
            describe("quando a view for anexada") {
                beforeEach {
                    setup()
                    repositoriesListPresenter.attachView(view: view)
                }
                
                it("então deverá carregar os dados") {
                    expect(service.fetchRepositoriesCalled).to(beTrue())
                }
            }
            
            describe("quando o serviço de busca de repositórios retornar") {
                beforeEach {
                    setup()
                }
                context("com sucesso") {
                    beforeEach {
                        setup()
                        repositoriesListPresenter.attachView(view: view)
                        repositoriesListPresenter.requestSucceded(repositories: [.dummyRepositoryResponse], state: .initial)
                    }
                    it("então deverá carregar os repositórios na tela") {
                        expect(view.reloadDataCalled).to(beTrue())
                    }
                    
                    it("então deverá salvar os repositórios") {
                        expect(repositoriesListPresenter.getTotalRepositories()).to(equal(1))
                    }
                    
                    it("então o repositório salvo deverá estar correto") {
                        expect(repositoriesListPresenter.getRepository(at: 0)).to(equal(Repository.dummyRepositoryResponse))
                    }
                }
                
                context("com falha") {
                    beforeEach {
                        setup()
                        repositoriesListPresenter.attachView(view: view)
                        repositoriesListPresenter.requestFailed(error: .makeRequest)
                    }
                    it("então deverá mostrar um alerta") {
                        expect(view.showAlertCalled).to(beTrue())
                        expect(view.showAlertMessage).to(equal("Número de requests excedido. Tente novamente em 60 minutos."))
                    }
                }
            }
        }
    }
}

class RepositoriesInputSpy: RepositoriesInput {
    var fetchRepositoriesCalled: Bool?
    var loadingStatusCalled: Bool?
    var hasMoreToDownloadStatusCalled: Bool?
    var output: RepositoriesOutput?

    func fetchRepositories() {
        fetchRepositoriesCalled = true
    }
    
    func loadingStatus() -> Bool {
        loadingStatusCalled = true
        return true
    }
    
    func hasMoreToDownloadStatus() -> Bool {
        hasMoreToDownloadStatusCalled = true
        return true
    }
}

class RepositoriesViewSpy: RepositoriesView {
    var updateScrollTopBackCalled: Bool?
    var reloadDataCalled: Bool?
    var reloadDataState: DataState?
    var showAlertCalled: Bool?
    var showAlertMessage: String?
    
    func updateScrollTopBack(_ status: Bool) {
        updateScrollTopBackCalled = true
    }
    
    func reloadData(_ state: DataState) {
        reloadDataCalled = true
        reloadDataState = state
    }
    
    func showAlert(_ message: String) {
        showAlertCalled = true
        showAlertMessage = message
    }
}

extension Repository: Equatable {
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.name == rhs.name && lhs.stars == rhs.stars
        return areEqual
    }
    
    static var dummyRepositoryResponse: Repository {
        return .init(
            id: 123,
            name: "SuperSwift",
            stars: 2000,
            author: .dummyAuthorResponse
        )
    }
}

private extension Author {
    static var dummyAuthorResponse: Author {
        return .init(
            name: "Brad",
            avatar: "https://avatars2.githubusercontent.com/u/7115804?v=4"
        )
    }
}
