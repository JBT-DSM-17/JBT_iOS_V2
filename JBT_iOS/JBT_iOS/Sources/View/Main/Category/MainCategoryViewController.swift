import UIKit
import SnapKit
import Then
import Foundation
import RxDataSources

struct GoodsModel: Codable {
    var items: [Item]
}

struct Item: Codable {
    let id: Int
    let picture: String
    let name: String
    let price: Int
    let location, locationDetail, description: String

    enum CodingKeys: String, CodingKey {
        case id, name, price, location, picture
        case locationDetail = "location_detail"
        case description
    }
}

extension GoodsModel: SectionModelType {
    init(original: GoodsModel, items: [Item]) {
        self = original
        self.items = items
    }
}

class MainCategoryViewController: UIViewController {
    
    let category: [String] = ["못난이", "충청남도", "충청북도", "경상남도", "경상북도", "전라남도", "전라북도", "경기도", "강원도"]
 
    var goodsData: GoodsModel = GoodsModel(items: [])
                               
    let navigationBar = MainCategoryNavigationBar()
    
    private let categoryRegionView = MainCategoryRegionView()
    
    private var foodCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
            $0.minimumInteritemSpacing = 18
            $0.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(MainPrizeCell.self,
                        forCellWithReuseIdentifier: MainPrizeCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func attribute() {
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
        
        navigationBar.leftButtonTapAction = {
            print("Left button tapped")
        }
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        navigationBar.setTitle("건어물")
        navigationBar.setTitleFont(UIFont.pretendard(size: 16, weight: .semibold))
        navigationBar.setLeftButtonImage(image: UIImage(systemName: "arrow.left")!)
        
        categoryRegionView.categoryAllShow = {
            print("전체 해제 됨")
            self.foodCollectionView.reloadData()
        }
        
        categoryRegionView.categorySelected = {
            print("\(self.category[$0]) 카테고리 클릭 됨")
            self.foodCollectionView.reloadData()
        }
    }
    
    func layout() {
        [navigationBar, categoryRegionView, foodCollectionView].forEach { view.addSubview($0) }
        
        navigationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        categoryRegionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(49.0)
        }

        foodCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryRegionView.snp.bottom).offset(20.0)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets)
        }
    }
}

extension MainCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 182.0, height: 270.0)
    }
}

extension MainCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsData.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainPrizeCell.identifier,
            for: indexPath
        ) as? MainPrizeCell
        let model = goodsData.items[indexPath.row]
        print(model)
//        cell?.setup(id: model.id, image: model.picture, name: model.name, region: model.location, info: model.description, price: model.price)
        return cell ?? UICollectionViewCell()
    }
}

