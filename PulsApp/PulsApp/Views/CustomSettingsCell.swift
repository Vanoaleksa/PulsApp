
import UIKit
import SnapKit

final class CustomSettingsCell: UITableViewCell {

    private lazy var mainView: UIView = {
        var view = UIView()
        
        contentView.addSubview(view)
        
        return view
    }()
    
    lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        
        mainView.addSubview(imageView)
        
        return imageView
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right-arrow-black-image")
        
        mainView.addSubview(imageView)
        
        return imageView
    }()

    lazy var typeLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        
        mainView.addSubview(label)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CustomSettingsCell")
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)

        mainView.backgroundColor = UIColor(red: 241/255, green: 240/255, blue: 245/255, alpha: 0.6)
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = CGColor(red: 226/255, green: 224/255, blue: 232/255, alpha: 1)
        mainView.layer.cornerRadius = 12
    }
}

//MARK: - Constraints
extension CustomSettingsCell {
    
    private func setupLayout() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        cellImage.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-15)
        }
    }
}

