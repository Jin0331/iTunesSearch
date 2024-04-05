//
//  ViewController.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/5/24.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let disposeBag = DisposeBag()
        view.backgroundColor = .red
        
        iTunesSearchManager.shared.fetchiTunesSearchData(router: .search(term: "카카오"), type: iTunesSearchList.self)
            .subscribe(with: self) { owner, value in
                print(value)
            } onError: { _, error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    
    
}

