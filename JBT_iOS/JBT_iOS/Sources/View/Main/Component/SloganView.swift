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
    private let backView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let sloganLabel = UILabel().then {
        $0.text = "유통 마진 쫙 뺀 만족스러운 거래"
        $0.font = .pretendard(size: 13, weight: .regular)
        $0.textColor = .white
    }
    private let logoLabel = UILabel().then {
        $0.text = "ㅈㅂㅌ"
        $0.font = .sokcho(size: 15)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green700
        addSubview(backView)
        [ sloganLabel, logoLabel ].forEach { backView.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        sloganLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        logoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(7)
            $0.left.equalTo(sloganLabel.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
    }
}
