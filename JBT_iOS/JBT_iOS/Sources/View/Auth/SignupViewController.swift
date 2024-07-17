import UIKit
import SnapKit
import Then


class SignupViewController: UIViewController {
    
    private let titleLabel = JBTLoginTitleLabel(text: "회원가입")
    private let idInputTF = JBTLoginTextField(type: .id)
    private let pwInputTF = JBTLoginTextField(type: .pw)
    private let suggestionView = JBTSuggestionView(message: "이미 가입했다면?", buttonTitle: "로그인하기")
    private let nextbutton = JBTLoginBottomButton().then {
        $0.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    let numberLabel2 = UILabel().then {
        $0.font = .pretendard(size: 18, weight: .semibold)
        $0.textAlignment = .right
    }
    
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        print("아니 지훈아 말 좀 들어")
        navigationController?.pushViewController(UserInfoViewController(id: idInputTF.currentText(), pw: pwInputTF.currentText()), animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [titleLabel, idInputTF, pwInputTF, suggestionView, nextbutton, numberLabel2 ].forEach { view.addSubview($0) }
        
        nextbutton.buttonTitle = "다음"
            
        self.view.backgroundColor = .white
        
        
        suggestionView.buttonTapped = {
//            print("Adfasdfadfs")
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        var attributedString = NSMutableAttributedString(string: "1/2")
        attributedString.addAttribute(.foregroundColor, value: UIColor.green500, range: NSRange(location: 0, length: 1))

        // UILabel에 NSAttributedString 설정
        numberLabel2.attributedText = attributedString
        
        
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
        numberLabel2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(57.5)
            $0.right.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(380)
            $0.bottom.equalToSuperview().inset(853.5)
        }
    }
}
