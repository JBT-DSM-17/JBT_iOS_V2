import UIKit
import SwiftUI
import SnapKit
import Then
import RxSwift
import RxCocoa

class HeaderView: UICollectionReusableView {
    private let categories = BehaviorRelay<[String]>(value: ["건어물", "청과류", "축산물", "수산물", "농산물"])
    private let disposeBag = DisposeBag()
    let selectedCategory = PublishRelay<String>()
    
    private lazy var categoryCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 20
            $0.itemSize = CGSize(width: 60, height: 78)
        }
    ).then {
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    private let bannerView = UIHostingController(rootView: BannerView()).view.then {
        $0.frame = .zero
    }
    
    private let suggestionLabel = UILabel().then {
        $0.text = "ㅈㅂㅌ이 추천하는 특산품"
        $0.font = .pretendard(size: 18, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            categoryCollectionView,
            bannerView,
            suggestionLabel
        ].forEach { self.addSubview($0) }
        
        categories.bind(to: categoryCollectionView.rx.items(
            cellIdentifier: "CategoryCell",
            cellType: CategoryCell.self
        )) { _, category, cell in
            cell.setup(name: category)
        }.disposed(by: disposeBag)
        
        categoryCollectionView.rx.itemSelected
            .map { self.categories.value[$0.row] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(78)
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        suggestionLabel.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(20)
            $0.height.equalTo(21)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
