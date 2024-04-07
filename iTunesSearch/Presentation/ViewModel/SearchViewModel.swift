//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel : ViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap : ControlEvent<Void>
        let searchText : ControlProperty<String>
    }
    
    struct Output {
        let search : PublishSubject<[iTunesSearch]>
    }
    
    func transform(input: Input) -> Output {
        
        let searchResult = PublishSubject<[iTunesSearch]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .map { return String($0) }
            .flatMap {
                iTunesSearchManager.shared.fetchiTunesSearchData(router: .search(term: $0), type: iTunesSearchList.self)
            }
            .subscribe(with: self, onNext: { owner, value in
                searchResult.onNext(value.results)
            }, onError: { _, _ in
                // make Toast by Notification Center
            })
            .disposed(by: disposeBag)
        
        return Output(search: searchResult)
    }
    
    
}
