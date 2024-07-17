import UIKit
import SnapKit
import Then


class LoginViewController: UIViewController {
    
    private let titleLabel = JBTLoginTitleLabel(text: "로그인")
    private let idInputTF = JBTLoginTextField(type: .id)
    private let pwInputTF = JBTLoginTextField(type: .pw)
    private let suggestionView = JBTSuggestionView(message: "아직 가입하지 않았다면?", buttonTitle: "회원가입")
    private let loginbutton = JBTLoginBottomButton()
    
//    let numberLabel = UILabel().then {
//        $0.font = .pretendard(size: 18, weight: .semibold)
//        $0.textAlignment = .right
//        $0.text = "1/2"
//    }
//    

    let numberLabel = UILabel().then {
        $0.font = .pretendard(size: 18, weight: .semibold)
        $0.textAlignment = .right
    }

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // UILabel에 NSAttributedString 설정
        
        
        
        loginbutton.buttonTitle = "다음"
        
        loginbutton.addAction(UIAction { [weak self] _ in
            print("아니 지훈아 말 좀 들어")
        }, for: .touchUpInside)
        
        
        
        suggestionView.buttonTapped = {
            print("Adfasdfadfs")
            self.navigationController?.pushViewController(SignupViewController(), animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
        
        view.backgroundColor = .white
        layout()
    }

    func layout() {
        [titleLabel, idInputTF, pwInputTF, suggestionView, loginbutton ].forEach { view.addSubview($0) }
        
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
        
        loginbutton.snp.makeConstraints {
            $0.top.equalTo(suggestionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        
        
    }
}

