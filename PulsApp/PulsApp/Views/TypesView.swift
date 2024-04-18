
import UIKit
import SnapKit

class TypesView: UIView{
    
    public weak var typesDelegate: TypesDelegate?
    private var type: AnalyzeTypes
    private var imageView: UIImageView!
    private var typesLabel: UILabel!
    private var image: UIImageView!
    
    init(type: AnalyzeTypes, image: UIImageView) {
        self.type = type
        self.image = image
        super.init(frame: .zero)
        setupView(typesText: type.typesString)
        setupLayout()
        tapGesture()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(typesText: String){
        imageView = UIImageView(image: UIImage(named: "RectangleWithBorder"))
        imageView.contentMode = .scaleAspectFit
        
        typesLabel = UILabel()
        typesLabel.font = .systemFont(ofSize: 16.adjusted)
        typesLabel.textColor = .black
        typesLabel.text = typesText
        
        image.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
        self.addSubview(typesLabel)
        self.addSubview(image)
    }
    
    private func tapGesture(){
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAndChooseTypes)))
    }
    
    public func typesChangeStateSelected(isSelected: Bool){
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: isSelected == true ? "RectangleWithBorder" : "RectangleWithoutBorder")
        }
    }
    
    @objc private func tapAndChooseTypes(){
        typesDelegate?.finalDefinitionType(type: type)
    }
}

extension TypesView {
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        typesLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).offset(100.adjusted)
            make.centerX.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


