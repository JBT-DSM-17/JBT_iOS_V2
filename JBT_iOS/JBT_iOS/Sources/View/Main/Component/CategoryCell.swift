import UIKit
import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let categoryImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }
    private let categoryLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .pretendard(size: 12, weight: .medium)
        $0.textAlignment = .center
    }
}

extension CategoryCell {
    func setup(name: String) {
        switch name {
        case "건어물":
            categoryImageView.image = .dried
        case "청과류":
            categoryImageView.image = .fruits
        case "축산물":
            categoryImageView.image = .livestocks
        case "수산물":
            categoryImageView.image = .fish
        case "농산물":
            categoryImageView.image = .produce
        default:
            categoryImageView.image = .init(systemName: "circle.fill")
        }
        categoryLabel.text = name
        layout()
    }
    
    func layout() {
        [categoryImageView, categoryLabel].forEach { contentView.addSubview($0) }
        
        categoryImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(categoryImageView.snp.bottom).offset(4)
            $0.height.equalTo(14)
            $0.centerX.bottom.equalToSuperview()
        }
    }
}
