//
//  SearchTableViewCell.swift
//  SeSACRxThreads
//
//  Created by jack on 2024/04/01.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    let rateStartImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .red
    }
    
    let moreInfoStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    let rateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .darkGray
        $0.textAlignment = .left
    }
    
    let corpLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    let categoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .darkGray
        $0.textAlignment = .right
    }
    
    let imageInfoStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 5
        $0.axis = .horizontal
    }
    
    let imageItem1 = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let imageItem2 = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let imageItem3 = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    var disposeBag = DisposeBag()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
     
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        selectionStyle = .none
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(rateStartImageView)
        contentView.addSubview(moreInfoStackView)
        contentView.addSubview(imageInfoStackView)
        
        [rateLabel, corpLabel,categoryLabel].forEach { moreInfoStackView.addArrangedSubview($0) }
        [imageItem1, imageItem2,imageItem3].forEach { imageInfoStackView.addArrangedSubview($0)}
        
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        rateStartImageView.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(10)
            make.leading.equalTo(appIconImageView)
            make.size.equalTo(20)
        }
        
        moreInfoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(rateStartImageView)
            make.leading.equalTo(rateStartImageView.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(40)
        }
        
        imageInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(rateStartImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    func updateUI(data : iTunesSearch) {
        
        appNameLabel.text = data.trackCensoredName
        appIconImageView.kf.setImage(with: URL(string:data.artworkUrl100))
        
        rateLabel.text = String(format: "%.2f", data.averageUserRating)
        corpLabel.text = data.sellerName
        categoryLabel.text = data.genres[0]
        
        (0...2).forEach {
            guard $0 < imageInfoStackView.arrangedSubviews.count, let temp = imageInfoStackView.arrangedSubviews[$0] as? UIImageView else { return }
            temp.kf.setImage(with: URL(string: data.screenshotUrls[$0]))
        }
    }
}

