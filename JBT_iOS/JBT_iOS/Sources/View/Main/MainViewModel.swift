import UIKit
import RxSwift
import RxRelay
import RxDataSources
import Moya

class MainViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<GoodsAPI>()
    let categories = BehaviorRelay<[String]>(value: ["건어물", "청과류", "축산물", "수산물", "농산물"])
    var productsData = BehaviorRelay<[GoodsModel]>(value: [GoodsModel(items: [
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: "전라남도 안에 있는 도시 아니고", sellerName: "이태영"),
    ])])

    let selectedCategory = PublishRelay<String>()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<GoodsModel>(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPrizeCell.identifier, for: indexPath) as? MainPrizeCell ?? .init()
        let goods = dataSource.sectionModels[0].items[indexPath.row]
        cell.setup(id: goods.id, image: goods.picture, name: goods.name, sellerName: goods.sellerName, region: goods.location, info: goods.name, price: goods.price)
        return cell
    }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView ?? .init()
        header.isUserInteractionEnabled = true
        header.selectedCategory
            .bind(to: self.selectedCategory)
            .disposed(by: self.disposeBag)
        return header
    })
    
    func getAllproductData() {
        provider.request(.goodsCategory(category: nil, location: nil, isBad: false), completion: { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(GoodsModel.self, from: result.data) {
                        self.productsData.accept([data])
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
}
