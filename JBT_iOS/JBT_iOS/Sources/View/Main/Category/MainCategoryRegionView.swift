import UIKit
import SnapKit
import Then

class MainCategoryRegionView: UIView {
    
    let category: [String] = ["못난이", "충청남도", "충청북도", "경상남도", "경상북도", "전라남도", "전라북도", "경기도", "강원도"]
    
    public var categorySelected: (([String]) -> Void)?
    public var categoryAllShow: (() -> Void)?
    
    private var selectedIndexPaths: Set<IndexPath> = []
                                      
    private var categoryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 9
            $0.minimumInteritemSpacing = 9
            $0.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(MainCategoryRegionCell.self,
                        forCellWithReuseIdentifier: MainCategoryRegionCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.allowsMultipleSelection = true // Enable multiple selection
        }
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.backgroundColor = .white
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    func layout() {
        [categoryCollectionView].forEach { self.addSubview($0) }

        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainCategoryRegionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.row {
        case 0, 7, 8:
            return CGSize(width: 61.0, height: 33.0)
        default:
            return CGSize(width: 73.0, height: 33.0)
        }
    }
}

extension MainCategoryRegionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCategoryRegionCell.identifier,
            for: indexPath
        ) as? MainCategoryRegionCell
        let model = category[indexPath.row]
        cell?.setup(text: model)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPaths.insert(indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as? MainCategoryRegionCell
        cell?.isSelected = true
        notifySelectionChanged()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedIndexPaths.remove(indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as? MainCategoryRegionCell
        cell?.isSelected = false
        notifySelectionChanged()
    }
    
    private func notifySelectionChanged() {
        let selectedIndexes = selectedIndexPaths.map { category[$0.row] }
        if selectedIndexes.isEmpty {
            categoryAllShow?()
        } else {
            categorySelected?(selectedIndexes)
        }
    }
}
