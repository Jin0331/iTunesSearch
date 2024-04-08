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
        let search : BehaviorSubject<[iTunesSearch]>
        let seletedItem : PublishRelay<iTunesSearch>
    }
    
    func transform(input: Input) -> Output {
        
        let searchResult = BehaviorSubject<[iTunesSearch]>(value : [])
        let selectedItem = PublishRelay<iTunesSearch>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .map { String($0)}
            .flatMap {
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
        
        //        Observable.combineLatest(input.tableViewTap, searchResult)
        //            .bind(with: self) { owner, value in
        //                let item = value.1[value.0.row]
        //                selectedItem.accept(item)
        //            }
        //            .disposed(by: disposeBag)
        
        return Output(search: searchResult, seletedItem:selectedItem)
    }
    
    
}
