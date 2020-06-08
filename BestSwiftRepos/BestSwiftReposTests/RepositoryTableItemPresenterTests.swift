//
//  RepositoryTableItemPresenterTests.swift
//  BestSwiftReposTests
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import BestSwiftRepos

class RepositoryTableItemPresenterTests: QuickSpec {
    
    override func spec() {
        var view: RepositoryTableItemViewSpy!
        var repositoryTableItemPresenter: RepositoryTableItemPresenter!

        func setup() {
            view = RepositoryTableItemViewSpy()
            repositoryTableItemPresenter = RepositoryTableItemPresenter(repository: Repository.dummyRepositoryResponse)
            repositoryTableItemPresenter.attachView(view)
        }
        
        describe("RepositoryTableItemPresenter") {
            
            beforeEach {
                setup()
            }
            
            describe("quando for instanciado e a view acessada") {
                beforeEach {
                    setup()
                }
                
                it("então deverá chamar o setup da view") {
                    expect(view.setupViewCalled).to(beTrue())
                }
                
                it("então deverá atribuir o nome repositorio") {
                    expect(view.setRepoTitleCalled).to(beTrue())
                    expect(view.repoTitlePassed).to(equal("Repositório:"))
                }
                
                it("então deverá atribuir o nome estrelas") {
                    expect(view.setRepoStarsTitleCalled).to(beTrue())
                    expect(view.repoStarsTitlePassed).to(equal("Estrelas:"))
                }
                
                it("então deverá atribuir o nome autor") {
                    expect(view.setAuthorTitleCalled).to(beTrue())
                    expect(view.authorTitlePassed).to(equal("Autor:"))
                }
                
                it("então deverá passar o nome do repositório") {
                    expect(view.setRepoNameCalled).to(beTrue())
                    expect(view.repoNamePassed).to(equal("SuperSwift"))
                }
                
                it("então deverá passar o número de estrelas") {
                    expect(view.setRepoStarsCalled).to(beTrue())
                    expect(view.repoStarsPassed).to(equal("2000"))
                }
                
                it("então deverá passar o nome do autor") {
                    expect(view.setAuthorNameCalled).to(beTrue())
                    expect(view.authorNamePassed).to(equal("Brad"))
                }
                
                it("então deverá passar a foto do autor") {
                    expect(view.setAuthorAvatarCalled).to(beTrue())
                    expect(view.authorAvatarPassed).to(equal("https://avatars2.githubusercontent.com/u/7115804?v=4"))
                }
            }
        }
    }
}

private class RepositoryTableItemViewSpy: RepositoryTableItemView {
    var setupViewCalled: Bool?
    var setRepoTitleCalled: Bool?
    var repoTitlePassed: String?
    var setRepoStarsTitleCalled: Bool?
    var repoStarsTitlePassed: String?
    var setAuthorTitleCalled: Bool?
    var authorTitlePassed: String?
    var setRepoNameCalled: Bool?
    var repoNamePassed: String?
    var setRepoStarsCalled: Bool?
    var repoStarsPassed: String?
    var setAuthorNameCalled: Bool?
    var authorNamePassed: String?
    var setAuthorAvatarCalled: Bool?
    var authorAvatarPassed: String?
    
    func setupView() {
        setupViewCalled = true
    }
    
    func setRepoTitle(_ title: String) {
        setRepoTitleCalled = true
        repoTitlePassed = title
    }
    
    func setRepoStarsTitle(_ title: String) {
        setRepoStarsTitleCalled = true
        repoStarsTitlePassed = title
    }
    
    func setAuthorTitle(_ title: String) {
        setAuthorTitleCalled = true
        authorTitlePassed = title
    }
    
    func setRepoName(_ name: String) {
        setRepoNameCalled = true
        repoNamePassed = name
    }
    
    func setRepoStars(_ stars: String) {
        setRepoStarsCalled = true
        repoStarsPassed = stars
    }
    
    func setAuthorName(_ name: String) {
        setAuthorNameCalled = true
        authorNamePassed = name
    }
    
    func setAuthorAvatar(_ photo: String) {
        setAuthorAvatarCalled = true
        authorAvatarPassed = photo
    }
}
