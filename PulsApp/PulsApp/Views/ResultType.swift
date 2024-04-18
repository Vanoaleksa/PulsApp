
import UIKit
import SnapKit

class ResultType: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        updateAnalyze = { type in
            DispatchQueue.main.async { [weak self] in
                self?.updateAnalyzeHandelr(type: type)
            }
        }
    }
    
    var updateAnalyze:((AnalyzeTypes) -> ())?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 20.adjusted
        self.backgroundColor = UIColor(red: 0.945, green: 0.941, blue: 0.961, alpha: 1)
        self.layer.borderColor = UIColor(red: 0.886, green: 0.878, blue: 0.91, alpha: 1).cgColor
        self.layer.borderWidth = 1
        constraintsOfImage()
    }
    
    lazy var resultImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    private func constraintsOfImage() {
        
        resultImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(26.adjusted)
            make.height.equalTo(26.adjusted)
        }
    }
    
    private func updateAnalyzeHandelr(type:AnalyzeTypes) {
        switch type {
        case .coffee:
            resultImage.image = UIImage(named: "Resting-image")
        case .active:
            resultImage.image = UIImage(named: "Active-image")
        case .sleep:
            resultImage.image = UIImage(named: "Sleep-image")
        default:
            break
        }
    }
}
