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
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .gray400
        $0.backgroundColor = .clear
    }
    private let searchTextField = UITextField().then {
        $0.placeholder = "상품 검색"
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 16
        $0.addLeftPadding(margin: 48)
    }
    private let bannerView = UIView().then {
        $0.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        [
            sloganView,
            searchTextField,
            searchImageView,
            bannerView
        ].forEach { view.addSubview($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sloganView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(sloganView.snp.bottom).offset(12)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.left.equalTo(searchTextField.snp.left).offset(15)
            $0.width.height.equalTo(18)
        }
        bannerView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(160)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

#Preview {
    let vc = MainViewController()
    return vc
}
