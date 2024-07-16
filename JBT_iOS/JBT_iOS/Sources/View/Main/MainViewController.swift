//
//  MainViewController.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/16/24.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    private let sloganView = SloganView()
    private let searchTextField = UITextField().then {
        $0.placeholder = "상품 검색"
        $0.backgroundColor = .lightGray
    }
    private let bannerView = UIView().then {
        $0.backgroundColor = .green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [
            sloganView,
            searchTextField,
            bannerView
        ].forEach { view.addSubview($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sloganView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        searchBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(48)
            $0.left.equalToSuperview().inset(24)
        }alToSuperview().inset(29)
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(searchBackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(160)
        }
    }
}

#Preview {
    let vc = MainViewController()
    return vc
}
