
import UIKit
import SnapKit

final class ProfileParametrsTableViewCell: UITableViewCell {
    
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

    lazy var typeLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        
        mainView.addSubview(label)
        
        return label
    }()
    
    lazy var paramTextField: UITextField = {
        var textField = UITextField()
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = UIColor(red: 113/255, green: 102/255, blue: 229/255, alpha: 1)
        textField.delegate = self
        textField.textAlignment = .right
        
        mainView.addSubview(textField)
        
        return textField
    }()
    
    lazy var paramNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 113/255, green: 102/255, blue: 229/255, alpha: 1)

        mainView.addSubview(label)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ProfileParametrsTableViewCell")
        
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

extension ProfileParametrsTableViewCell: UITextFieldDelegate {
//MARK: - Ограничение ввода более 3х символов
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Проверяем, является ли новая длина текста больше 3
        guard let text = textField.text,
              let range = Range(range, in: text) else {
            return false
        }
        
        let newText = text.replacingCharacters(in: range, with: string)
        
        return newText.count <= 3
    }
}

//MARK: - Constraints
extension ProfileParametrsTableViewCell {
    
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
        
        paramNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-10)
            make.height.equalTo(16)
//            make.width.equalToSuperview().dividedBy(6)
        }
        
        paramTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(paramNameLabel.snp.leading).offset(-7)
            make.height.equalTo(16)
            make.width.equalToSuperview().dividedBy(5.3)
        }
    }
}
