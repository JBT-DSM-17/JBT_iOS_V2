//
//  NewGoodsViewController.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/17/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import PhotosUI
import Moya

class NewGoodsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var isRepresentative = true
    private var isClassB = false
    private var representativeImage = UIImage()
    private var detailImage = UIImage()
    
    private let naviBar = MainCategoryNavigationBar()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let representativeLabel = UILabel().then {
        $0.text = "대표 사진을 첨부해 주세요."
        $0.font = .pretendard(size: 16, weight: .medium)
    }
    private let representativeButton = UIButton().then {
        $0.setImage(.photoPicker, for: .normal)
        $0.imageView?.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    private let produceNameField = JBTLoginTextField(type: .custom(title: "상품명을 입력해 주세요.", placeholder: "상품명(1~40자 제한)"))
    private let infoField = JBTLoginTextField(type: .custom(title: "상품 정보를 입력해 주세요.", placeholder: "상품 정보(1~1000자 제한)"))
    private let priceField = JBTLoginTextField(type: .custom(title: "판매가를 입력해 주세요.", placeholder: "판매가(1000000 이하)"))
    private let regionLabel = UILabel().then {
        $0.text = "원산지를 선택해 주세요."
        $0.font = .pretendard(size: 16, weight: .medium)
    }
    private let regionCV = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.estimatedItemSize = CGSize(width: 73, height: 33)
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 8
            $0.minimumInteritemSpacing = 8
        }
    ).then {
        $0.register(TagListCell.self, forCellWithReuseIdentifier: "region")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let regionDetailField = JBTLoginTextField(type: .custom(title: "", placeholder: "상세 지역  -  예) 나주"))
    private let typeLabel = UILabel().then {
        $0.text = "특산물의 종류를 선택해 주세요."
        $0.font = .pretendard(size: 16, weight: .medium)
    }
    private let typeCV = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: 61, height: 33)
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 10
        }
    ).then {
        $0.register(TagListCell.self, forCellWithReuseIdentifier: "type")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let bClassButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        $0.setTitle("  못난이(B급, 생채기) 상품인가요?", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.tintColor = .green800
        $0.titleLabel?.font = .pretendard(size: 12, weight: .medium)
    }
    private let transportationField = JBTLoginTextField(type: .custom(title: "배송 정보를 입력해 주세요.", placeholder: "배송 정보"))
    private let detailPhotoLabel = UILabel().then {
        $0.text = "상품 상세 사진을 첨부해 주세요."
        $0.font = .pretendard(size: 16, weight: .medium)
    }
    private let detailPhotoButton = UIButton().then {
        $0.setImage(.photoPicker, for: .normal)
        $0.imageView?.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
    }
    private let selectedPhotoView = SelectedPhotoView().then {
        $0.image = .detailFoodDummy
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    private let uploadButton = JBTLoginBottomButton().then {
        $0.buttonTitle = "업로드"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true

        naviBar.leftButtonTapAction = { self.navigationController?.popViewController(animated: true) }
        naviBar.setTitle("")
        naviBar.setLeftButtonImage(image: UIImage(systemName: "arrow.left")!)
        
        [naviBar, scrollView].forEach { 
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.addSubview(contentView)
        [
            representativeLabel,
            representativeButton,
            produceNameField,
            infoField,
            priceField,
            regionLabel,
            regionCV,
            regionDetailField,
            typeLabel,
            typeCV,
            bClassButton,
            transportationField,
            detailPhotoLabel,
            detailPhotoButton,
            selectedPhotoView,
            uploadButton
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        selectedPhotoView.isHidden = true
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        naviBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalToSuperview().inset(24)
        }
        representativeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        representativeButton.snp.makeConstraints {
            $0.top.equalTo(representativeLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        produceNameField.snp.makeConstraints {
            $0.top.equalTo(representativeButton.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        infoField.snp.makeConstraints {
            $0.top.equalTo(produceNameField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        priceField.snp.makeConstraints {
            $0.top.equalTo(infoField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        regionLabel.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(40)
            $0.left.equalToSuperview()
        }
        regionCV.snp.makeConstraints {
            $0.top.equalTo(regionLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(76)
        }
        regionDetailField.snp.makeConstraints {
            $0.top.equalTo(regionCV.snp.bottom).offset(-12)
            $0.horizontalEdges.equalToSuperview()
        }
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(regionDetailField.snp.bottom).offset(40)
            $0.left.equalToSuperview()
        }
        typeCV.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(33)
        }
        bClassButton.snp.makeConstraints {
            $0.top.equalTo(typeCV.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(2)
        }
        transportationField.snp.makeConstraints {
            $0.top.equalTo(bClassButton.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
        }
        detailPhotoLabel.snp.makeConstraints {
            $0.top.equalTo(transportationField.snp.bottom).offset(40)
            $0.left.equalToSuperview()
        }
        detailPhotoButton.snp.makeConstraints {
            $0.top.equalTo(detailPhotoLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        selectedPhotoView.snp.makeConstraints {
            $0.centerY.equalTo(detailPhotoButton.snp.centerY)
            $0.left.equalTo(detailPhotoButton.snp.right).offset(16)
            $0.width.height.equalTo(100)
        }
        uploadButton.snp.makeConstraints {
            $0.top.equalTo(detailPhotoButton.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(64)
        }
    }
    
    func bind() {
        representativeButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.isRepresentative = true
                var config = PHPickerConfiguration()
                config.selectionLimit = 1
                config.filter = .any(of: [.images, .livePhotos, .screenshots])
                let photoPickerVC = PHPickerViewController(configuration: config)
                photoPickerVC.delegate = owner
                self.present(photoPickerVC, animated: true)
            }).disposed(by: disposeBag)
        
        let regions = BehaviorRelay<[String]>(value: ["강원도", "경기도", "경상남도", "경상북도", "전라남도", "전라북도", "충청남도", "충청북도"])
        let types = BehaviorRelay<[String]>(value: ["건어물", "농산물", "수산물", "청과류", "축산물"])
        
        regions.bind(to: regionCV.rx.items(
            cellIdentifier: "region",
            cellType: TagListCell.self
        )) { idx, region, cell in
            cell.title = region
        }.disposed(by: disposeBag)
        
        types.bind(to: typeCV.rx.items(
            cellIdentifier: "type",
            cellType: TagListCell.self
        )) { idx, type, cell in
            cell.title = type
        }.disposed(by: disposeBag)
        
        var selectedRegion = ""
        regionCV.rx.itemSelected
            .subscribe(onNext: { idxPath in
                selectedRegion = regions.value[idxPath.row]
            }).disposed(by: disposeBag)
        
        var selectedType = ""
        typeCV.rx.itemSelected
            .subscribe(onNext: { idxPath in
                selectedType = types.value[idxPath.row]
            }).disposed(by: disposeBag)
        
        bClassButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.isClassB.toggle()
                owner.bClassButton.setImage(owner.isClassB ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
            }).disposed(by: disposeBag)
        
        detailPhotoButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.isRepresentative = false
                var config = PHPickerConfiguration()
                config.selectionLimit = 1
                config.filter = .any(of: [.images, .livePhotos, .screenshots])
                let photoPickerVC = PHPickerViewController(configuration: config)
                photoPickerVC.delegate = owner
                self.present(photoPickerVC, animated: true)
            }).disposed(by: disposeBag)
        
        uploadButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let provider = MoyaProvider<GoodsAPI>(plugins: [MoyaLoggingPlugin()])
                
                provider.request(.registerNewGoods(dto: NewGoodsRequestDTO(
                    representative: owner.representativeImage.jpegData(compressionQuality: 0.5) ?? .init(),
                    name: owner.produceNameField.currentText(),
                    description: owner.infoField.currentText(),
                    category: selectedType,
                    price: Int(owner.priceField.currentText()) ?? 10000,
                    location: selectedRegion,
                    detailLocation: owner.regionDetailField.currentText(),
                    isClassB: owner.isClassB,
                    detail: owner.detailImage.jpegData(compressionQuality: 0.5) ?? .init()
                ))) { result in
                    switch result {
                    case let .success(response):
                        print("등록 성공", response)
                        self.navigationController?.popViewController(animated: true)
                    case let .failure(error):
                        print("등록 실패", error)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = ""
    }
}

extension NewGoodsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            let itemProvider = results.first?.itemProvider
            
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async { [self] in
                        if self.isRepresentative {
                            representativeImage = image as? UIImage ?? .init()
                            representativeButton.setImage(representativeImage, for: .normal)
                        } else {
                            detailImage = image as? UIImage ?? .init()
                            selectedPhotoView.image = detailImage
                            selectedPhotoView.isHidden = false
                        }
                    }
                }
            }
        }
}

#Preview {
    let vc = NewGoodsViewController()
    return vc
}
