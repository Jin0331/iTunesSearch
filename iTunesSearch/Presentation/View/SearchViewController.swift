//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    let tableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.rowHeight = 340
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    let searchBar = UISearchBar().then {
        $0.placeholder = "게임, 앱, 스토리 등"
        $0.backgroundImage = UIImage()
    }
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        
        let recentText = PublishSubject<String>()
        let input = SearchViewModel.Input(searchButtonTap: searchBar.rx.searchButtonClicked, searchText: searchBar.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.search
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: SearchTableViewCell.identifier,
                    cellType: SearchTableViewCell.self)) { (row, element, cell) in
                        
                        cell.updateUI(data: element)
                        
                    }
                    .disposed(by: disposeBag)
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "검색"
//        navigationItem.titleView = searchBar
    }
}


extension SearchViewController {
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
