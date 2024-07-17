import UIKit
import RxSwift
import RxRelay
import RxDataSources

class MainViewModel {
    private let disposeBag = DisposeBag()
    let categories = BehaviorRelay<[String]>(value: ["건어물", "청과류", "축산물", "수산물", "농산물"])
    let productsData = BehaviorRelay<[GoodsModel]>(value: [GoodsModel(items: [
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: ""),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: ""),

    ])])
    let selectedCategory = PublishRelay<String>()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<GoodsModel>(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPrizeCell.identifier, for: indexPath) as? MainPrizeCell ?? .init()
        let goods = dataSource.sectionModels[0].items[indexPath.row]
        cell.setup(id: goods.id, image: goods.picture, name: goods.name, region: goods.location, info: goods.description, price: "")
        return cell
    }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView ?? .init()
        header.isUserInteractionEnabled = true
        header.selectedCategory
            .bind(to: self.selectedCategory)
            .disposed(by: self.disposeBag)
        
        self.selectedCategory
            .subscribe(onNext: { data in
                print("data is", data)
            }).disposed(by: self.disposeBag)
        return header
    })
}
