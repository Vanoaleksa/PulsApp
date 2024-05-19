
import UIKit
import SnapKit

protocol MealsCollectionViewCellDelegate: AnyObject {
    func didTapSeeAllButton(with dishes: [DishModel])
}

final class MealsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MealsCollectionViewCellDelegate?
    var dishesArr: [DishModel]?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(UIColor(red: 255/255, green: 134/255, blue: 56/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(openMealsVC), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false

        self.addSubview(collectionView)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
        
        DispatchQueue.main.async {
            self.scrollToMiddle()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.addSubview(titleLabel)
        self.addSubview(seeAllButton)
        
        collectionView.register(DishesCollectionViewCell.self,
                                forCellWithReuseIdentifier: "\(DishesCollectionViewCell.self)")
    }
    
    // Метод для прокрутки к середине
    private func scrollToMiddle() {
        let middleIndex = IndexPath(item: collectionView.numberOfItems(inSection: 0) / 2, section: 0)
        collectionView.scrollToItem(at: middleIndex, at: .centeredHorizontally, animated: false)
    }
    
    @objc func openMealsVC() {
        if let dishesArr = dishesArr {
            delegate?.didTapSeeAllButton(with: dishesArr)
        }
    }
}

extension MealsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishesArr != nil ? dishesArr!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DishesCollectionViewCell.self)", for: indexPath) as! DishesCollectionViewCell
        
        guard dishesArr != nil else {return cell}
        
        let item = dishesArr![indexPath.row]
        
        cell.mainImage.image = item.mainImage
        cell.dishNameLabel.text = item.dishName
        cell.cookingTimeLabel.text = item.cookingTime
        cell.kkalLabel.text = item.kkal
        
        return cell
    }
}


extension MealsCollectionViewCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MealsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    //Setup a height to cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2.25, height: collectionView.bounds.height)
    }
}

extension MealsCollectionViewCell {
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(15)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(19)
            make.width.equalToSuperview().dividedBy(8.15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
