//
//  TagListCell.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/18/24.
//

import UIKit
import SnapKit
import Then

class TagListCell: UICollectionViewCell {
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .green200 : .white
        }
    }
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(34)
        }
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.green200.cgColor
    }
}
