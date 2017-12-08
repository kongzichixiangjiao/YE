//
//  RepositoryListViewModel.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryListViewModel {
    
    // MARK: - Inputs
    let setCurrentLanguage: AnyObserver<String>
    let chooseLanguage: AnyObserver<()>
    let selectRepository: AnyObserver<RepositoryViewModel>
    let reload: AnyObserver<()>
    
    // MARK: - Outputs
    let repositories: Observable<[RepositoryViewModel]>
    let title: Observable<String>
    let alertMessage: Observable<String>
    let showRepository: Observable<URL>
    let showLanguageList: Observable<()>
    
    init(initialLanguage: String, githubService: GithubService = GithubService()) {
        let _reload = PublishSubject<()>()
        reload = _reload.asObserver()
        
        let _currentLanguage = BehaviorSubject<String>(value: initialLanguage)
        setCurrentLanguage = _currentLanguage.asObserver()
        
        title = _currentLanguage.asObserver()
            .map {"\($0)"}
        
        let _alertMessage = PublishSubject<String>()
        alertMessage = _alertMessage.asObserver()
        
        repositories = Observable.combineLatest(_reload, _currentLanguage) {
            _, language in
            language
            }.flatMapLatest({ language in
                githubService.getMostPopularRepositories(byLanguage: language)
                    .catchError({ (error) -> Observable<[Repository]> in
                        _alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                    })
            }).map { repositories in
                repositories.map(RepositoryViewModel.init)
        }
        
        let _selectRepository = PublishSubject<RepositoryViewModel>()
        selectRepository = _selectRepository.asObserver()
        showRepository = _selectRepository.asObservable().map { $0.url }
        
        let _chooseLanguage = PublishSubject<Void>()
        chooseLanguage = _chooseLanguage.asObserver()
        showLanguageList = _chooseLanguage.asObservable()
    }
    
}
