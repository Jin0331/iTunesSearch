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
                            observer.onNext(success)
                        case .failure(let error):
                            switch error {
                            case .invalidURL:
                                observer.onError(error)
                            case .parameterEncodingFailed:
                                observer.onError(error)
                            case .urlRequestValidationFailed:
                                observer.onError(error)
                            default :
                                observer.onError(error)
                            }
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
