import UIKit

import SnapKit
import Then

class JBTLoginTitleLabel: UILabel {
    let label = UILabel().then {
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.numberOfLines = 2
    }

    init(text: String) {
        super.init(frame: .zero)
        
        label.text = "\(text)하고\nㅈㅂㅌ을 사용해보세요!"
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(label)

        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

