//
//  GlobalButton.swift
//  PulsApp
//
//  Created by MacBook on 22.03.24.
//

import UIKit
import SnapKit

class GlobalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 34.adjusted
        self.titleLabel?.font = .systemFont(ofSize: 18)
        self.backgroundColor = UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        
    }
    
    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(68.adjusted)
        }
    }
}
