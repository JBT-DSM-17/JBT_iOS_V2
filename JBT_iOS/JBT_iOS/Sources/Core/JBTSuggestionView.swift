import UIKit
import SnapKit
import Then


class JBTSuggestionView: UIView {
    
    public var buttonTapped: (() -> Void)?
 
    private let messageLabel = UILabel().then {
        $0.font = .pretendard(size: 12, weight: .medium)
        $0.textColor = .black
    }
    
    
    private let moveButton = UIButton(type: .system).then {
        $0.setTitleColor(.green500, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 12, weight: .medium)
        
    }
    
    init(message: String, buttonTitle: String) {
        super.init(frame: .zero)
        
        messageLabel.text = message
        moveButton.setTitle(buttonTitle, for: .normal)
        
        [ messageLabel, moveButton ].forEach { addSubview($0) }
        
        moveButton.addTarget(self, action: #selector(moveButtonTapped), for: .touchUpInside)
    }
    @objc func moveButtonTapped() {
        buttonTapped?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
        }
        moveButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalTo(messageLabel.snp.right).offset(4)
            $0.right.equalToSuperview()
        }
    }
    
    public func buttonTapped(buttonTapped: @escaping () -> Void) {
        self.buttonTapped = buttonTapped
    }
}
