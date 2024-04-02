
import UIKit

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        typesLabel = UILabel()
        typesLabel.font = .systemFont(ofSize: 16.adjusted)
        typesLabel.textColor = .black
        typesLabel.text = typesText
        typesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        self.addSubview(typesLabel)
        self.addSubview(image)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            typesLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 100),
            typesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            image.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
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
