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
    
    func fetchiTunesSearchData<T:Decodable>(router : iTunesSearchAPIRouter, type : T.Type) -> Single<Result<T, AFError>> {
        
        return Single<Result<T, AFError>>.create { single in
            switch router {
            case .search:
                AF.request(router)
                    .responseDecodable(of: type) { response in
                        switch response.result {
                        case .success(let success):
                            single(.success(.success(success)))
                        case .failure(let error):
                            switch error {
                            default :
                                single(.success(.success(error as! T)))
                            }
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
