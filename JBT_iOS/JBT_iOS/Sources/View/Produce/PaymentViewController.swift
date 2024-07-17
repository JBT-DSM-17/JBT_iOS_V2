import UIKit
import SnapKit
import Then


class PaymentViewController: UIViewController {
    private let backView = UIView().then {
        $0.backgroundColor = .green500
    }
    private let receiptBackView = UIView().then {
        $0.backgroundColor = .white
    }
    private let checkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle.fill")
        $0.tintColor = .green500
    }
    private let finishPaymentsLabel = UILabel().then {
        $0.text = "결제가 완료되었습니다!"
        $0.textColor = .green500
        $0.font = .pretendard(size: 24, weight: .semibold)
    }
    private let buyInfoLabel = UILabel().then {
        $0.text = "구매 정보"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    private let buyManyLabel = UILabel().then {
        $0.text = "구매 수량"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    private let buyMuchLabel = UILabel().then {
        $0.text = "구매 금액"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    private let buyDateLabel = UILabel().then {
        $0.text = "구매 일시"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    private let buyHowLabel = UILabel().then {
        $0.text = "결제 수단"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    private let lineImageView = UIImageView().then {
        $0.image = .line4
    }
    
    private let loginbutton = JBTLoginBottomButton()
    
    
    
    let informationlabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .right
    }
    
    
    let numberLabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .right
    }
    
    
    let moneyLabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .right
    } 
    
    
    
    let dayLabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .right
    }
    
    
    
    let howLabel = UILabel().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .right
    }
    
    public func setLabels(informationText: String, numberText: String, moneyText: String, dayText: String, howText: String) {
        informationlabel.text = informationText
        numberLabel.text = numberText
        moneyLabel.text = moneyText
        dayLabel.text = dayText
        howLabel.text = howText
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginbutton.buttonTitle = "홈으로 가기"
        self.view.backgroundColor = .gray50
        
        view.addSubview(backView)
        backView.addSubview(receiptBackView)
        
        [
            backView,
            receiptBackView,
            checkImageView,
            finishPaymentsLabel,
            buyInfoLabel,
            buyManyLabel,
            buyMuchLabel,
            buyDateLabel,
            buyHowLabel,
            loginbutton,
            lineImageView,
            informationlabel,
            numberLabel,
            moneyLabel,
            dayLabel,
            howLabel
        ].forEach { view.addSubview($0) }
        
        
        
        receiptBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(144)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(364)
        }
        
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(652)
        }
        
        checkImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(175)
            $0.top.equalToSuperview().inset(184)
            $0.bottom.equalToSuperview().inset(668)
            $0.width.height.equalTo(80)
        }
        
        
        finishPaymentsLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(104)
            $0.bottom.equalToSuperview().inset(619)
            $0.top.equalTo(checkImageView.snp.bottom).offset(20)
            $0.width.equalTo(221)
            $0.height.equalTo(29)
        }
        
        buyInfoLabel.snp.makeConstraints {
            //            $0.top.equalTo(receiptBackView.snp.bottom).offset(225)
            //            $0.left.equalTo(receiptBackView.snp.right).offset(16)
            //            $0.bottom.equalTo(receiptBackView.snp.top).offset(180)
            //            $0.right.equalTo(receiptBackView.snp.left).offset(306)
            $0.bottom.equalToSuperview().inset(544)
            $0.top.equalToSuperview().inset(369)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(330)
        }
        
        buyManyLabel.snp.makeConstraints {
            $0.top.equalTo(buyInfoLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(330)
            $0.bottom.equalToSuperview().inset(509)
        }
        
        buyMuchLabel.snp.makeConstraints {
            $0.top.equalTo(buyManyLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(330)
            $0.bottom.equalToSuperview().inset(474)
        }
        
        buyDateLabel.snp.makeConstraints {
            $0.top.equalTo(buyMuchLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(330)
            $0.bottom.equalToSuperview().inset(439)
        }
        
        buyHowLabel.snp.makeConstraints {
            $0.top.equalTo(buyDateLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(330)
            $0.bottom.equalToSuperview().inset(404)
        }
        loginbutton.snp.makeConstraints {
            $0.top.equalTo(buyHowLabel.snp.bottom).offset(240)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        
        lineImageView.snp.makeConstraints {
            $0.top.equalTo(finishPaymentsLabel.snp.bottom).offset(40.0)
            $0.width.equalToSuperview().inset(32.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        informationlabel.snp.makeConstraints {
            $0.top.equalTo(lineImageView.snp.bottom).offset(17)
            $0.bottom.equalToSuperview().inset(545)
            $0.right.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(152)
        }
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(informationlabel.snp.bottom).offset(17)
            $0.bottom.equalToSuperview().inset(510)
            $0.right.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(152)
        }
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(17)
            $0.right.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(152)
            $0.bottom.equalToSuperview().inset(475)
        }
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(moneyLabel.snp.bottom).offset(17)
            $0.right.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(152)
            $0.bottom.equalToSuperview().inset(440)
        }
        
        howLabel.snp.makeConstraints{
            $0.top.equalTo(dayLabel.snp.bottom).offset(17)
            $0.right.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(152)
            $0.bottom.equalToSuperview().inset(405)
        }
        
        self.loginbutton.addAction(UIAction { _ in
            print("아니 지훈아 말 좀 들어")
        }, for: .touchUpInside)
        
        
        
    }
}
