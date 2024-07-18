import UIKit
import SwiftUI
import SnapKit
import Then
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    private let sloganView = SloganView()
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .gray400
        $0.backgroundColor = .clear
    }
    
    public var searchId: [Int] = []

    private let searchTextField = UITextField().then {
        $0.placeholder = "상품 검색"
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 14
        $0.addLeftPadding(margin: 48)
    }
    private lazy var entireCV = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
            $0.minimumInteritemSpacing = 18
            $0.itemSize = CGSize(width: 182, height: 270)
            $0.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 357)
        }
    ).then {
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        $0.register(MainPrizeCell.self, forCellWithReuseIdentifier: MainPrizeCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
    }
    private let plusButton = UIButton(type: .system).then {
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        $0.setImage(image, for: .normal)
        $0.contentMode = .scaleToFill
        $0.tintColor = .white
        $0.backgroundColor = .green600
        $0.layer.cornerRadius = 30
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 4
    }
    private let searchCV = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
            $0.minimumInteritemSpacing = 18
            $0.itemSize = CGSize(width: 182, height: 270)
            $0.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 0, right: 24)
        }
    ).then {
        $0.register(MainPrizeCell.self, forCellWithReuseIdentifier: "SearchCV")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        super.viewDidLoad()
        
        [
            sloganView,
            searchTextField,
            searchImageView,
            entireCV,
            plusButton,
            searchCV
        ].forEach { view.addSubview($0) }
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sloganView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(sloganView.snp.bottom).offset(12)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.left.equalTo(searchTextField.snp.left).offset(15)
            $0.width.height.equalTo(18)
        }
        entireCV.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.right.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(20)
        }
    
        searchCV.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        let searchResult = PublishRelay<[Item]>()
        self.viewModel.getAllproductData()
        
        viewModel.productsData
            .bind(to: entireCV.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        entireCV.rx.itemSelected
            .subscribe(onNext: { [self] idxPath in
                print("cell ID : \(viewModel.productsData.value[0].items[idxPath[1]].id)")
                self.navigationController?.pushViewController(MainDetailViewController(id: viewModel.productsData.value[0].items[idxPath[1]].id), animated: true)
            }).disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .subscribe(with: self, onNext: { owner, text in
                owner.searchCV.isHidden = text.count < 1 ? true : false
                owner.searchId = []
                let data = owner.viewModel.productsData.value[0].items
                Observable.just(data.filter { $0.name.contains(text) })
                    .bind(to: searchResult)
                    .disposed(by: owner.disposeBag)
            }).disposed(by: disposeBag)
        
        viewModel.selectedCategory
            .distinctUntilChanged()
            .subscribe(onNext: { category in
                self.navigationController?.pushViewController(MainCategoryViewController(category: category), animated: true)
            }).disposed(by: disposeBag)
        
        
        searchResult.bind(to: searchCV.rx.items(
            cellIdentifier: "SearchCV",
            cellType: MainPrizeCell.self
        )) { idx, data, cell in
            cell.setup(id: data.id, image: data.picture, name: data.name, sellerName: data.sellerName, region: data.location, info: data.name, price: data.price)
            self.searchId.append(cell.cellId)
        }.disposed(by: disposeBag)

        searchCV.rx.itemSelected
            .subscribe(onNext: { idxPath in
                self.navigationController?.pushViewController(MainDetailViewController(id: self.searchId[idxPath[1]]), animated: true)
            }).disposed(by: disposeBag)
        
        plusButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                self.navigationController?.pushViewController(NewGoodsViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
