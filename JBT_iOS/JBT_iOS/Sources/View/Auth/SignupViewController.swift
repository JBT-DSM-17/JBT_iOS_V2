import UIKit
import SnapKit
import Then


class SignupViewController: UIViewController {
    
    private let titleLabel = JBTLoginTitleLabel(text: "회원가입")
    private let idInputTF = JBTLoginTextField(type: .id)
    private let pwInputTF = JBTLoginTextField(type: .pw)
    private let suggestionView = JBTSuggestionView(message: "이미 가입했다면?", buttonTitle: "로그인하기")
    private let nextbutton = JBTLoginBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [titleLabel, idInputTF, pwInputTF, suggestionView, nextbutton ].forEach { view.addSubview($0) }
        
        nextbutton.buttonTitle = "다음"
        
        self.nextbutton.addAction(UIAction { _ in
            print("아니 지훈아 말 좀 들어")
            self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
        }, for: .touchUpInside)
            
        self.view.backgroundColor = .white
        
        
        suggestionView.buttonTapped = {
//            print("Adfasdfadfs")
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        nextbutton.snp.makeConstraints {
            $0.top.equalTo(suggestionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
}
