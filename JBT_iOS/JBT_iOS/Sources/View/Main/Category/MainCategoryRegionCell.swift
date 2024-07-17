import UIKit

import SnapKit
import Then

class MainCategoryRegionCell: UICollectionViewCell {
    static let identifier: String = "MainCategoryRegionCell"
    
    let backView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.green100.cgColor
    }
    
    let textLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
        $0.textAlignment = .center
    }
    
    override var isSelected: Bool {
        didSet {
            backView.backgroundColor = isSelected ? UIColor.green100 : UIColor.clear
        }
    }
}

extension MainCategoryRegionCell {
    func setup(text: String) {
        textLabel.text = text
        layout()
    }
    
    func layout() {
        [backView, textLabel].forEach { contentView.addSubview($0) }
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.width.equalToSuperview().inset(12.0)
            $0.centerX.equalToSuperview()
        }
    }
}
