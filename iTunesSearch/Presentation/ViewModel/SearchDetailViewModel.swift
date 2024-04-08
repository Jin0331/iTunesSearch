//
//  SearchDetailViewModel.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchDetailViewModel : ViewModel {
    
    var item : iTunesSearch?
    let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        let iTunesImageList : BehaviorRelay<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let receiveItem = BehaviorRelay(value: item)
        let iTunesImageList = BehaviorRelay<[String]>(value: [])
        
        receiveItem
            .bind(with: self) { owner, value in
                
                guard let value = value else { return }
                iTunesImageList.accept(value.screenshotUrls)
            }
            .disposed(by: disposeBag)
        
        return Output(iTunesImageList: iTunesImageList)
    }
}
