//
//  SloganView.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/16/24.
//

import UIKit
import SnapKit
import Then

class SloganView: UIView {
    private let sloganLabel = UILabel().then {
        $0.text = "유통 마진 쫙 뺀 만족스러운 거래"
        $0.font = .pretendard(size: 10, weight: .medium)
        $0.textColor = .white
    }
    private let logoLabel = UILabel().then {
        $0.font = .sokcho(size: 14)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green500
        [ sloganLabel, logoLabel ].forEach { addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sloganLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.snp.centerX).offset(-86)
        }
        logoLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.left.equalTo(self.snp.centerX).offset(46)
        }
    }
}
