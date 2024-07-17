import UIKit
import RxSwift
import RxRelay
import RxDataSources

class MainViewModel {
    private let disposeBag = DisposeBag()
    let categories = BehaviorRelay<[String]>(value: ["건어물", "청과류", "축산물", "수산물", "농산물"])
    let productsData = BehaviorRelay<[MainSection]>(value: [MainSection(items: [
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "안녕하세요 안녕안녕", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "해커톤이 언제 끝날까용", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "하이하이 하이하이 나이나이", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "최강 삼성 오", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "라이온즈여", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "승리를 향해", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "달려나가자", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "한화의 황영묵", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "날려버려라 한화의", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "승리를 원하잖아", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500"),
        GoodsModel(image: UIImage(named: "foodDummy")!, name: "이태영", region: "전라남도", info: "개쩌는 포케 10어ㅜ 정말 마있는 초케ㄹ먹어", price: "11,500")
    ])])
    let selectedCategory = PublishRelay<String>()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<MainSection>(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPrizeCell.identifier, for: indexPath) as? MainPrizeCell ?? .init()
        let goods = dataSource[0].items
        cell.setup(
            image: goods[indexPath.row].image,
            name: goods[indexPath.row].name,
            region: goods[indexPath.row].region,
            info: goods[indexPath.row].info,
            price: goods[indexPath.row].price
        )
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
