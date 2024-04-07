//
//  BaseViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

class BaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureNavigation()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
        view.backgroundColor = .white
    }
    
    func configureNavigation() {
        
        // 배경색
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        
        // title 크게
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)]
        
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
