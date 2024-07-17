import UIKit
import SnapKit
import Then


class UserInfoViewController: UIViewController {
    
    private let titleLabel = JBTLoginTitleLabel(text: "회원가입")
    private let idInputTF = JBTLoginTextField(type: .name)
    private let pwInputTF = JBTLoginTextField(type: .tel)
    private let suggestionView = JBTSuggestionView(message: "이미 가입했다면?", buttonTitle: "로그인하기")
    private let signUpButton = JBTLoginBottomButton()
    
    override func viewDidLoad() {}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        
        signUpButton.buttonTitle = "회원가입"
        
        [
            titleLabel,
            idInputTF,
            pwInputTF,
            suggestionView,
            signUpButton
        ].forEach { view.addSubview($0) }
        
        
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
        
        suggestionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(144)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(suggestionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
}
