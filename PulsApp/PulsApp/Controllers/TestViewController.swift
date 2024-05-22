
import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: "\(TestCollectionViewCell.self)")
    }
}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TestCollectionViewCell.self)", for: indexPath) as! TestCollectionViewCell
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TestViewController: UICollectionViewDelegateFlowLayout {
    //Setup a height to cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2.1, height: collectionView.bounds.height / 3.5)
    }
}

//MARK: - UICollectionViewDelegate
extension TestViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = QuickTestViewController()
        nextVC.modalPresentationStyle = .fullScreen

        self.present(nextVC, animated: true)
    }
}

extension TestViewController {
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}
