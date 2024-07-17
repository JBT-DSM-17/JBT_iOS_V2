import UIKit
import RxSwift
import RxRelay
import RxDataSources

class MainViewModel {
    private let disposeBag = DisposeBag()
    let categories = BehaviorRelay<[String]>(value: ["건어물", "청과류", "축산물", "수산물", "농산물"])
    let productsData = BehaviorRelay<[GoodsModel]>(value: [GoodsModel(items: [
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: "전라남도 안에 있는 도시 아니고"),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: "전라북도 아니고"),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: "광주 광역시"),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: "경기도 광주 아니고"),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: "진짜 찐"),
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: "광주라는 도시"),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: "대도시"),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: "혁신도시 옆에 있는"),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: "가짜 도시?"),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: "나주 배 냠냠"),
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: "전라남도 안에 있는 도시 아니고"),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: "전라북도 아니고"),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: "광주 광역시"),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: "경기도 광주 아니고"),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: "진짜 찐"),
        Item(id: 1, picture: "", name: "asdf", price: 1, location: "", locationDetail: "", description: "광주라는 도시"),
        Item(id: 2, picture: "", name: "1324", price: 1, location: "", locationDetail: "", description: "대도시"),
        Item(id: 3, picture: "", name: "fdsg", price: 1, location: "", locationDetail: "", description: "혁신도시 옆에 있는"),
        Item(id: 4, picture: "", name: "qer", price: 1, location: "", locationDetail: "", description: "가짜 도시?"),
        Item(id: 5, picture: "", name: "qwer", price: 1, location: "", locationDetail: "", description: "나주 배 냠냠")

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
