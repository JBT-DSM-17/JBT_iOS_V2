import UIKit
import SnapKit
import Then

class MainCategoryNavigationBar: UIView {

    public var leftButtonTapAction: (() -> Void)?

    private let leftButton = UIButton().then {
        $0.tintColor = UIColor.black
    }
    private let titleLabel = UILabel()

    private lazy var leftItemsStackView = UIStackView(arrangedSubviews: [leftButton]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        configureActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.addSubview(leftItemsStackView)
        self.addSubview(titleLabel)

        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(24.0)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        leftItemsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureActions() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
    }

    @objc private func  leftButtonTapped() {
        leftButtonTapAction?()
    }
}

extension MainCategoryNavigationBar {
    @discardableResult
    public func setLeftButtonImage(image: UIImage) -> Self {
        self.leftButton.setImage(image, for: .normal)
        return self
    }

    @discardableResult
    public func setTitle(_ title: String) -> Self {
        self.titleLabel.text = title
        self.titleLabel.textAlignment = .center
        return self
    }

    @discardableResult
    public func setTitleColor(_ color: UIColor) -> Self {
        self.titleLabel.textColor = color
        return self
    }

    @discardableResult
    public func setTitleFont(_ font: UIFont) -> Self {
        self.titleLabel.font = font
        return self
    }
}
