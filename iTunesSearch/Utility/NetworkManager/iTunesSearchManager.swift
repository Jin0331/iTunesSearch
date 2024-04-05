//
//  iTunesSearchManager.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/5/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class iTunesSearchManager {
    
    static let shared = iTunesSearchManager()
    
    private init () { }
    
    func fetchiTunesSearchData<T:Decodable>(router : iTunesSearchAPIRouter, type : T.Type) -> Observable<T> {
        
        return Observable<T>.create { observer in
                
            switch router {
            case .search:
                AF.request(router)
                    .responseDecodable(of: type) { response in
                        switch response.result {
                        case .success(let success):
                            print("API Success")
                            print(success)
                            observer.onNext(success)
                        case .failure(let error):
                            print("API failure")
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
