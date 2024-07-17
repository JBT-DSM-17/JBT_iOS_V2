import UIKit

import SnapKit
import Then

class MainPrizeCell: UICollectionViewCell {
    static let identifier: String = "MainPrizeCell"
    
    public var cellId: Int = 0
    
    var goodsImage = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
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
        image: String,
        name: String,
        sellerName: String,
        region: String,
        info: String,
        price: Int
    ) {
        cellId = id
        let thumbnail = URL(string: image)
        let defaultImage = URL(string: "https://roout.co.kr/m/p/u/ga2ZC53/c/Jr4DeQNxB7p/i/1N9m2wovk8X.jpg?w=1080")
        goodsImage.imageFrom(url: (thumbnail ?? defaultImage)!)
        nameLabel.text = sellerName
        regionLabel.text = region
        infoLabel.text = info
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        priceLabel.text = "\(formattedPrice)원"
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
