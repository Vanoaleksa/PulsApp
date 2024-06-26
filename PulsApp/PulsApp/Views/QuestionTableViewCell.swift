
import UIKit
import SnapKit

final class QuestionTableViewCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        mainView.layer.borderColor = isSelected ?
        CGColor(red: 255/255, green: 134/255, blue: 56/255, alpha: 1) :
        CGColor(red: 226/255, green: 224/255, blue: 232/255, alpha: 1)
    }
    
    //Creating a UIView for make a space between cells
    lazy var mainView: UIView = {
        let view = UIView()
        
        contentView.addSubview(view)
        
        return view
    }()
    
    lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(red: 113/255, green: 102/255, blue: 229/255, alpha: 1)
        label.textAlignment = .center
        
        mainView.addSubview(label)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        
        mainView.addSubview(label)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "QuestionTableViewCell")
        
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
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = CGColor(red: 226/255, green: 224/255, blue: 232/255, alpha: 1)
        mainView.layer.cornerRadius = 12
        
    }
    

}

extension QuestionTableViewCell {
    private func setupLayout() {
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        letterLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(letterLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
}
