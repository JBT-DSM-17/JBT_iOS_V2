import UIKit
import SnapKit
import Then
import Moya

class UserInfoViewController: UIViewController {
    
    private var authProvider = MoyaProvider<AuthAPI>()
    
    private var userId: String = ""
    private var password: String = ""
    
    private let titleLabel = JBTLoginTitleLabel(text: "회원가입")
    private let idInputTF = JBTLoginTextField(type: .name)
    private let pwInputTF = JBTLoginTextField(type: .tel)
    private let suggestionView = JBTSuggestionView(message: "이미 가입했다면?", buttonTitle: "로그인하기")
    private let signUpButton = JBTLoginBottomButton()
    
    let numberLabel3 = UILabel().then {
        $0.font = .pretendard(size: 18, weight: .semibold)
        $0.textAlignment = .right
    }
    
    init (
        id: String,
        pw: String
    ) {
        super.init(nibName: nil, bundle: nil)
        userId = id
        password = pw
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        
        attribute()
        layout()
    }
    
    private func attribute() {
        suggestionView.buttonTapped = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        signUpButton.buttonTitle = "회원가입"
        
        signUpButton.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
        
        let numberLabel3 = UILabel().then {
            $0.font = .pretendard(size: 18, weight: .semibold)
        }
        numberLabel3.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        
        var attributedString = NSMutableAttributedString(string: "2/2")
        attributedString.addAttribute(.foregroundColor, value: UIColor.green500, range: NSRange(location: 0, length: 1))
        
        numberLabel3.textAlignment = .right
        numberLabel3.attributedText = attributedString
    }
    
    private func layout() {
        [
            titleLabel,
            idInputTF,
            pwInputTF,
            suggestionView,
            signUpButton,
            numberLabel3
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

        numberLabel3.snp.makeConstraints {
            $0.top.equalToSuperview().inset(57.5)
            $0.right.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(377)
            $0.bottom.equalToSuperview().inset(853.5)
            $0.width.equalTo(1000)
        }
    }

    private func signupLogin() {
        self.authProvider.request(.login(userId: self.userId, password: self.password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(AuthResponse.self, from: result.data) {
                        DispatchQueue.main.async {
                            Token.accessToken = data.accessToken
                            print("accessToken : \(String(describing: Token.accessToken))")
                            self.navigationController?.pushViewController(MainViewController(), animated: true)
                        }
                    } else {
                        print("auth json decode fail")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("\(err.localizedDescription)")
            }
        }
    }
    
    @objc func signButtonTapped() {
        self.authProvider.request(.signup(userId: self.userId, nickname: self.idInputTF.currentText(), phone: self.pwInputTF.currentText(), password: self.password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    print("회원가입 성공")
                    self.signupLogin()
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("\(err.localizedDescription)")
            }
        }
    }
}
