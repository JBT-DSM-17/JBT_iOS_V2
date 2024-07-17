import UIKit

import SnapKit
import Then

class MainPrizeCell: UICollectionViewCell {
    static let identifier: String = "MainPrizeCell"
    
    public var cellId: Int = 0
    
    let goodsImage = UIImageView().then {
        $0.layer.cornerRadius = 8
    }
    
    let nameLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 10, weight: .medium)
        $0.textAlignment = .left
    }
    
    let regionLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 10, weight: .medium)
        $0.textColor = UIColor.green500
        $0.textAlignment = .right
    }
    
    let infoLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    let priceLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
    }
}

extension MainPrizeCell {
    func setup(
        id: Int,
        image: UIImage,
        name: String,
        region: String,
        info: String,
        price: String
    ) {
        cellId = id
        goodsImage.image = image
        nameLabel.text = name
        regionLabel.text = region
        infoLabel.text = info
        priceLabel.text = price
        layout()
    }
    
    func layout() {
        [goodsImage, nameLabel, regionLabel, infoLabel, priceLabel].forEach { contentView.addSubview($0) }
        
        goodsImage.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.equalTo(182)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(goodsImage.snp.bottom).offset(12)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(12)
        }
        
        regionLabel.snp.makeConstraints {
            $0.top.equalTo(goodsImage.snp.bottom).offset(12)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(12)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(regionLabel.snp.bottom).offset(6)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(29)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(6)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(21)
        }
    }
}
