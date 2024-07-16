import UIKit

import SnapKit
import Then

class JBTLoginBottomButton: UIButton {
    var buttonTitle: String {
        get { buttonTitleLabel.text ?? "" }
        set { buttonTitleLabel.text = newValue }
    }
    
    private let backView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let buttonTitleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.textColor = .white
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.right")
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = .green
        
        addSubview(backView)
        
        [
            buttonTitleLabel,
            arrowImageView
        ].forEach { backView.addSubview($0) }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        buttonTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(3)
        }
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(18)
            $0.left.equalTo(buttonTitleLabel.snp.right).offset(4)
            $0.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



#Preview {
    let loginButton = JBTLoginBottomButton()
    loginButton.buttonTitle = "로그인"
    return loginButton
}
