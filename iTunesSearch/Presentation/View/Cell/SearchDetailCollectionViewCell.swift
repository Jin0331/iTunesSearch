//
//  SearchDetailCollectionViewCell.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import UIKit
import SnapKit
import Kingfisher
import Then

class SearchDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchDetailCollectionViewCell"
    
    let screenImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(screenImageView)
        
        screenImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(data : String) {
        
        screenImageView.kf.setImage(with: URL(string:data))
        
    }
}
