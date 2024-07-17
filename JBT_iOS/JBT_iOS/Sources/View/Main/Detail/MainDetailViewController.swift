import UIKit
import SnapKit
import Then
import Moya

struct GoodsDetailModel: Codable {
    let picture: String
    let name: String
    let price, otherPrice: Int
    let location, locationDetail, description: String
    let detail: String
    let seller: Seller
    
    enum CodingKeys: String, CodingKey {
        case picture, name, price
        case otherPrice = "other_price"
        case location
        case locationDetail = "location_detail"
        case description, detail, seller
    }
}


struct Seller: Codable {
    let nickname: String
    let introduce: String?
}


class MainDetailViewController: UIViewController {
    
    private let provider = MoyaProvider<GoodsAPI>()
    
    let naviBar = MainCategoryNavigationBar()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    private let stackView1 = UIStackView().then {
        $0.axis = .vertical
    }
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(named: "detailFoodDummy")
    }
    
    private let stackView2 = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .white
    }
    
    private let stackView4 = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let goodsInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private let regionStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    var nameLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.text = "이태영"
        $0.textAlignment = .left
        $0.textColor = UIColor.gray600
    }
    
    let regionLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
        $0.textColor = UIColor.green500
        $0.text = "전라남도"
        $0.textAlignment = .right
    }
    
    let infoLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = UIColor.gray700
        $0.text = "전라남도 유기농 샐러드 세트"
        $0.lineBreakMode = .byCharWrapping
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
    }
    
    let infoLabel2 = UILabel().then {
        $0.text = "타 플랫폼 최저가 16,000원"
        $0.textColor = UIColor.gray300
        $0.lineBreakMode = .byCharWrapping
        $0.font = UIFont.pretendard(size: 16, weight: .semibold)
    }
    
    let priceLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 32, weight: .semibold)
        $0.text = "11,500원"
        $0.textColor = UIColor.green700
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 3
    }
    
    let originLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .semibold)
        $0.text = "원산지"
        $0.textAlignment = .left
        $0.textColor = UIColor.black
    }
    
    let realRegionLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .semibold)
        $0.textColor = UIColor.black
        $0.text = "전라남도 나주"
        $0.textAlignment = .right
    }
    
    let lineView1 = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 1
    }
    
    let deliveryInfoLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .semibold)
        $0.text = "배송정보"
        $0.textAlignment = .left
        $0.textColor = UIColor.black
    }
    
    let deliveryRegionLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .semibold)
        $0.textColor = UIColor.black
        $0.text = "무료배송"
        $0.textAlignment = .right
    }
    
    let lineView2 = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 1
    }
    
    let detailInfoTitleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.textColor = UIColor.black
        $0.text = "상세정보"
        $0.textAlignment = .left
    }
    
    private let stackView3 = UIStackView().then {
        $0.axis = .vertical
    }
    
    let detailImageView = UIImageView().then {
        $0.image = UIImage(named: "detailInfoDummyImage")
    }
    
    let lineView4 = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 1
    }
    
    let introduceTitleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 10, weight: .medium)
        $0.textColor = UIColor.gray500
        $0.text = "판매자 소개"
        $0.textAlignment = .left
    }
    
    let sellerInfoLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
        $0.textColor = .black
        $0.text = "이태영 전라남도"
        $0.textAlignment = .left
    }
    
    let sellerInfoTextLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = UIColor.gray400
        $0.text = "안ㄴ여하세요ㅑ러ㅑ루ㅜ러ㅐㅜ라ㅓ 즐거운 폰케 먹으성-ㅗㅜㅞㅓㅔㅜ 안ㄴ여하세요ㅑ러ㅑ루ㅜ러ㅐㅜ라ㅓ 즐거운 폰케 먹으성-ㅗㅜㅞㅓㅔㅜ"
        $0.lineBreakMode = .byCharWrapping
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    let lineView5 = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 3
    }
    
    let buttonBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let lineVie6 = UIView().then {
        $0.backgroundColor = UIColor.gray50
        $0.layer.cornerRadius = 3
    }
    
    let buyButton = JBTLoginBottomButton()
    
    private var detailImageViewHeightConstraint: Constraint?
    
    
    
    init (
        id: Int
    ) {
        super.init(nibName: nil, bundle: nil)
        
        getDetailData(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDetailImageViewHeight()
        updateScrollViewContentSize()
    }
    
    func attribute() {
        view.backgroundColor = .white
        
        buyButton.buttonTitle = "구매하기"
        
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
        
        naviBar.leftButtonTapAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        naviBar.setTitle("")
        naviBar.setLeftButtonImage(image: UIImage(systemName: "arrow.left")!)
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    @objc func buyButtonTapped() {
        self.navigationController?.pushViewController(PaymentViewController(informationText: infoLabel.text!, numberText: "4개", moneyText: "11,500원", dayText: "2024-07-17  11:57", howText: "신용카드"), animated: true)
    }
    
    func getDetailData(id: Int) {
        provider.request(.goodsDetail(id: id), completion: {  res in
            switch res {
        case .success(let result):
            switch result.statusCode {
            case 200:
                if let data = try? JSONDecoder().decode(GoodsDetailModel.self, from: result.data) {
                    let thumbnail = URL(string: data.picture)
                    let defaultImage = URL(string: "https://roout.co.kr/m/p/u/ga2ZC53/c/Jr4DeQNxB7p/i/1N9m2wovk8X.jpg?w=1080")
                    self.mainImageView.imageFrom(url: (thumbnail ?? defaultImage)!)
                    self.nameLabel.text = data.seller.nickname
                    self.regionLabel.text = data.location
                    self.infoLabel.text = data.name
                    
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let formattedPrice = numberFormatter.string(from: NSNumber(value: data.otherPrice)) ?? "\(data.otherPrice)"
                    self.infoLabel2.text = "타 플랫폼 최저가 \(formattedPrice)원"
                    let formattedPrice1 = numberFormatter.string(from: NSNumber(value: data.price)) ?? "\(data.price)"
                    self.priceLabel.text = "\(formattedPrice1)원"
                    self.realRegionLabel.text = data.locationDetail
                    self.sellerInfoLabel.text = "\(data.seller.nickname) \(data.location)"
                    self.sellerInfoTextLabel.text = data.seller.introduce
                    
                } else {
                    print("goods json decode fail")
                }
            default:
                print(result.statusCode)
            }
        case .failure(let err):
            print("\(err.localizedDescription)")
        }
        })
    }
    
    
    func layout() {
        [naviBar, scrollView, buttonBackView].forEach { view.addSubview($0) }
        [stackView1, stackView2].forEach { scrollView.addSubview($0) }
        stackView1.addArrangedSubview(mainImageView)
        
        [goodsInfoStackView, regionStackView, stackView3, stackView4].forEach { stackView2.addSubview($0) }
        
        [nameLabel, regionLabel, infoLabel, infoLabel2, priceLabel, lineView].forEach { goodsInfoStackView.addArrangedSubview($0) }
        
        [originLabel, realRegionLabel, lineView1, deliveryInfoLabel, deliveryRegionLabel, lineView2, detailInfoTitleLabel].forEach{ regionStackView.addSubview($0) }
        
        stackView3.addSubview(detailImageView)
        
        [lineView4, introduceTitleLabel, sellerInfoLabel, sellerInfoTextLabel, lineView5].forEach { stackView4.addSubview($0) }
        
        [lineVie6, buyButton].forEach { buttonBackView.addSubview($0) }
        
        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.width.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView1.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(430)
        }
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView2.snp.makeConstraints {
            $0.top.equalTo(stackView1.snp.bottom).offset(16.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(3000)
        }
        
        goodsInfoStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(162.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        regionLabel.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(regionLabel.snp.bottom).offset(16.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(21.0)
        }
        
        infoLabel2.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(19.0)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel2.snp.bottom).offset(16.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(38.0)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(16.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(goodsInfoStackView.snp.bottom).offset(20.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(127.0)
        }
        
        originLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8.0)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(17.0)
        }
        
        realRegionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8.0)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(17.0)
        }
        
        lineView1.snp.makeConstraints {
            $0.top.equalTo(realRegionLabel.snp.bottom).offset(11.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        deliveryInfoLabel.snp.makeConstraints {
            $0.top.equalTo(lineView1.snp.bottom).offset(20.0)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(17.0)
        }
        
        deliveryRegionLabel.snp.makeConstraints {
            $0.top.equalTo(lineView1.snp.bottom).offset(20.0)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(17.0)
        }
        
        lineView2.snp.makeConstraints {
            $0.top.equalTo(deliveryRegionLabel.snp.bottom).offset(11.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        detailInfoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView2.snp.bottom).offset(20.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(21.0)
        }
        
        stackView3.snp.makeConstraints {
            $0.top.equalTo(regionStackView.snp.bottom).offset(20.0)
            $0.width.centerX.equalToSuperview()
        }
        
        detailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView4.snp.makeConstraints {
            $0.top.equalTo(stackView3.snp.bottom).offset(24.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(101.0)
        }
        
        lineView4.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        introduceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView4.snp.bottom).offset(4.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(12.0)
        }
        
        sellerInfoLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTitleLabel.snp.bottom).offset(8.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(17.0)
        }
        
        sellerInfoTextLabel.snp.makeConstraints {
            $0.top.equalTo(sellerInfoLabel.snp.bottom).offset(8.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(29.0)
        }
        
        lineView5.snp.makeConstraints {
            $0.top.equalTo(sellerInfoTextLabel.snp.bottom).offset(12.0)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        buttonBackView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(96)
        }
        
        lineVie6.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(lineVie6.snp.bottom).offset(11.0)
            $0.width.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.0)
        }
        
        detailImageView.snp.makeConstraints { make in
            detailImageViewHeightConstraint = make.height.equalTo(382).constraint
        }
    }
    
    private func updateDetailImageViewHeight() {
        guard let image = detailImageView.image else { return }
        let aspectRatio = image.size.height / image.size.width
        let width = view.frame.width - 48
        let height = width * aspectRatio
        
        detailImageViewHeightConstraint?.update(offset: height)
    }
    
    private func updateScrollViewContentSize() {
        let totalHeight = 430 + 16 + 20 + 127 + 20 + detailImageView.frame.height + 24 + 101 + 24 + 96 + 120
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
    }
}
