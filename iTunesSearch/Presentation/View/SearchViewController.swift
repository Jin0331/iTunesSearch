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
import Toast

final class SearchViewController: BaseViewController {
    
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
    
    private let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(searchButtonTap: searchBar.rx.searchButtonClicked,
                                          searchText: searchBar.rx.text.orEmpty,
                                          tableViewTap: tableView.rx.itemSelected
        )
        let output = viewModel.transform(input: input)
        
        
        output.search
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: SearchTableViewCell.identifier,
                    cellType: SearchTableViewCell.self)) { [weak self] (row, element, cell) in
                        
                        guard let self = self else { return }
                        if element.description.isEmpty {
                            self.view.makeToast("검색결과가 없습니다", duration: 2, position: .center)
                        } else {
                            cell.updateUI(data: element)
                        }
                    }
                    .disposed(by: disposeBag)
        
        output.seletedItem
            .withUnretained(self)
            .bind(onNext: { owner, value in
                let vc = SearchDetailViewController()
                vc.viewModel.item = value
                vc.updateUI(data: value)
                owner.navigationController?.pushViewController(vc, animated: true)
            })
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
