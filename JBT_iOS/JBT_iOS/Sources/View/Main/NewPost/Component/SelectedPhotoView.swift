//
//  SelectedPhotoCell.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SelectedPhotoView: UIView {
    private let disposeBag = DisposeBag()
    var image: UIImage {
        get { imageView.image ?? .init() }
        set {
            self.isHidden = false
            imageView.image = newValue
        }
    }
    
    private let imageView = UIImageView()
    private let deleteButton = UIButton(type: .system).then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 12, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 9
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [ imageView, deleteButton ].forEach { addSubview($0) }
        
        deleteButton.rx.tap
            .subscribe(onNext: {
                self.isHidden = true
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(29)
            $0.height.equalTo(18)
            $0.top.right.equalToSuperview().inset(8)
        }
    }
}
