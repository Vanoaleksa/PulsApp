//
//  CustomParametersCell.swift
//  PulsApp
//
//  Created by MacBook on 27.02.24.
//

import UIKit
import SnapKit

class CustomParametersCell: UITableViewCell {
        
    var isEmpty: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    lazy var mainView: UIView = {
        var view = UIView()
        
        contentView.addSubview(view)
        
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        var label = UILabel()
        label.text = "Parametr"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        
        contentView.addSubview(label)
        
        return label
    }()
    
    lazy var warningLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red: 226/255, green: 42/255, blue: 70/255, alpha: 1)
        label.textAlignment = .center
        label.isHidden = true
        
        contentView.addSubview(label)
        
        return label
    }()
    
    lazy var addParamButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "addButtonBlue"), for: .normal)
        button.setImage(UIImage(named: "addButtonRed"), for: .selected)
        button.addTarget(self, action: #selector(showTextField), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        return button
    }()
    
    lazy var paramTextField: UITextField = {
        var textField = UITextField()
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = UIColor(red: 113/255, green: 102/255, blue: 229/255, alpha: 1)
        textField.delegate = self
        textField.isHidden = true
        
        mainView.addSubview(textField)
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CustomParametersCell")
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI() {
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)

        mainView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 249/255, alpha: 0.6)
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = CGColor(red: 235/255, green: 233/255, blue: 240/255, alpha: 1)
        mainView.layer.cornerRadius = 12
    }
    
    @objc func showTextField() {
        addParamButton.isHidden = true
        paramTextField.isHidden = false
        paramTextField.becomeFirstResponder()
    }

//MARK: - Изменяем внешность, если поле пустое
    func updateAppearance() {
        
        if self.isEmpty == true {
            UIView.animate(withDuration: 1) {
                self.typeLabel.snp.updateConstraints { make in
                    make.top.equalTo(7)
                }
                self.layoutIfNeeded()
                self.warningLabel.isHidden = false
                self.addParamButton.isSelected = true

            }
        }
        perform(#selector(self.updateConstraintsBack), with: (Any).self , afterDelay: 3)
    }
    
    @objc func updateConstraintsBack() {
        UIView.animate(withDuration: 1) {
            self.typeLabel.snp.updateConstraints { make in
                make.top.equalTo(15)
            }
            self.layoutIfNeeded()
            self.warningLabel.isHidden = true
        }
        
    }
}

extension CustomParametersCell: UITextFieldDelegate {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if paramTextField.text?.isEmpty == true {
            paramTextField.isHidden = true
            addParamButton.isHidden = false
        }
        self.paramTextField.resignFirstResponder()
    }
}

extension CustomParametersCell {
    
    func setupLayout() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
        }
        
        addParamButton.snp.makeConstraints { make in
            make.centerY.equalTo(mainView)
            make.right.equalTo(-20)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        paramTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
    }
}
