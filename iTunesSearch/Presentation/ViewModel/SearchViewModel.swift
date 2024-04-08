//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class SearchViewModel : ViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap : ControlEvent<Void>
        let searchText : ControlProperty<String>
        let tableViewTap : ControlEvent<IndexPath>
    }
    
    struct Output {
        let search : PublishSubject<[iTunesSearch]>
        let seletedItem : PublishRelay<iTunesSearch>
    }
    
    func transform(input: Input) -> Output {
        
        let searchResult = PublishSubject<[iTunesSearch]>()
        let selectedItem = PublishRelay<iTunesSearch>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .map { String($0)}
            .flatMapLatest{
                iTunesSearchManager.shared.fetchiTunesSearchData(router: .search(term: $0), type: iTunesSearchList.self)
            }
            .debug()
            .subscribe(with: self, onNext: { owner, value in
                switch value{
                case .success(let success):
                    searchResult.onNext(success.results)
                case .failure(let failure):
                    searchResult.onNext([])
                }
            })
            .disposed(by: disposeBag)

        input.tableViewTap
            .withLatestFrom(searchResult) { indexPath, searchResults in
                return searchResults[indexPath.row]
            }
            .bind(to: selectedItem)
            .disposed(by: disposeBag)
        
        return Output(search: searchResult, seletedItem:selectedItem)
    }
    
    
}
