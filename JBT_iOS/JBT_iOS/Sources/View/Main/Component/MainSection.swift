import RxDataSources

struct MainSection {
    var items: [GoodsModel]
}

extension MainSection: SectionModelType {
    init(original: MainSection, items: [GoodsModel]) {
        self = original
        self.items = items
    }
}
