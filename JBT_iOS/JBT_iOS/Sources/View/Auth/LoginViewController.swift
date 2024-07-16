import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let titleLabel = JBTLoginTitleLabel(text: "로그인")
    private let idInputTF = JBTLoginTextField(type: .id)
    private let pwInputTF = JBTLoginTextField(type: .pw)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layout()
    }

    func layout() {
        [titleLabel, idInputTF, pwInputTF, ].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(58.0)
        }
        
        idInputTF.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(38.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(71.0)
        }
        
        pwInputTF.snp.makeConstraints {
            $0.top.equalTo(idInputTF.snp.bottom).offset(20.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(71.0)
        }
    }

}

