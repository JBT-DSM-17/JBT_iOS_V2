import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let label = JBTLoginTitleLabel(text: "로그인")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layout()
    }

    func layout() {
        [label].forEach { view.addSubview($0) }
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(58.0)
        }
    }

}

