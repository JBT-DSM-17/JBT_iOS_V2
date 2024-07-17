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
            $0.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
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
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(20)
        }
        searchCV.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        let searchResult = PublishRelay<[GoodsModel]>()
        
        viewModel.productsData
            .bind(to: entireCV.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        entireCV.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print(indexPath)
            }).disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .subscribe(with: self, onNext: { owner, text in
                searchCV.isHidden = text.count < 1 ? true : false
//                let goods = dataSource.sectionModels[0].items[indexPath.row]

                
                let data = viewModel.productsData.value[0]
                Observable.just(data.items.filter { $0.name.contains(text) })
                    .bind(to: searchResult)
                    .disposed(by: disposeBag)
            }).disposed(by: disposeBag)
        
        searchResult.bind(to: searchCV.rx.items(
            cellIdentifier: "SearchCV",
            cellType: MainPrizeCell.self
        )) { idx, data, cell in
            cell.setup(id: data.items[idx].id, image: data.items[idx].picture, name: data.items[idx].name, region: data.items[idx].location, info: data.items[idx].description, price: "")
        }.disposed(by: disposeBag)
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

#Preview {
    let vc = MainViewController()
    return vc
}
