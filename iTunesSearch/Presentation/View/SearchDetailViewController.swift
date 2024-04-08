//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class SearchDetailViewController: BaseViewController {

    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
        $0.bounces = false
    }
    
    let contentsView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let iconImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
    }
    
    let iconTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }
    
    let iconCorpLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .systemGray4
    }
    
    let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.white, for: .normal)
    }
    
    let releaseTitleLabel = UILabel().then {
        $0.text = "새로운 소식"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    let releaseVersionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .systemGray4
    }
    
    let releaseDescriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(SearchDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchDetailCollectionViewCell.identifier)
    }
    
    let mainDescriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }

    let viewModel = SearchDetailViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()

    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentsView)
        [iconImageView, iconTitleLabel, iconCorpLabel, downloadButton, releaseTitleLabel, releaseVersionLabel, releaseDescriptionLabel,
         collectionView, mainDescriptionLabel].forEach { contentsView.addSubview($0)}
        
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(contentsView).inset(10)
            $0.leading.equalTo(20)
            $0.size.equalTo(90)
        }
        
        iconTitleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView).inset(10)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
        iconCorpLabel.snp.makeConstraints { make in
            make.top.equalTo(iconTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(iconTitleLabel)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView.snp.bottom)
            make.leading.equalTo(iconTitleLabel)
            make.width.equalTo(60)
        }
        
        releaseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.leading.equalTo(iconImageView)
        }
        
        releaseVersionLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView)
        }
        
        releaseDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseVersionLabel.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView)
            make.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(3000)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseDescriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView)
            make.trailing.equalToSuperview()
            make.height.equalTo(600)
        }
        
        mainDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView)
            make.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(3000)
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func bind () {
        
        let input = SearchDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.iTunesImageList
            .bind(to: collectionView.rx.items(cellIdentifier: SearchDetailCollectionViewCell.identifier, cellType: SearchDetailCollectionViewCell.self)) { (row, element, cell) in
                cell.updateUI(data: element)
            }
            .disposed(by: disposeBag)
        
    }
    
    func updateUI(data :iTunesSearch) {
        
        iconImageView.kf.setImage(with: URL(string:data.artworkUrl60))
        iconTitleLabel.text = data.trackCensoredName
        iconCorpLabel.text = data.sellerName
        releaseVersionLabel.text = "버전 \(data.version)"
        releaseDescriptionLabel.text = data.releaseNotes
        mainDescriptionLabel.text = data.description
        
    }
}

extension SearchDetailViewController {
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 550)
        layout.scrollDirection = .horizontal
        return layout
    }
}
