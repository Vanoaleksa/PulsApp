
import UIKit
import SnapKit

protocol ResultViewDelegate {
    func saveToDBAndCloseResultView()
}

class ResultScreenView: UIView {
    
    var delegate: ResultViewDelegate?
    
    let darkView:UIView = {
        let view = UIView()
        view.alpha = 0.5
        view.backgroundColor = .black
        
        return view
    }()
    
    var resultWindow = ResultWindow()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .clear
        resultWindow.delegateResult = self
        
        self.insertSubview(darkView, at: 0)
        self.addSubview(resultWindow)
    }
    
    func updateLabelsValues(bpm: Int, date: Double, analyzType: AnalyzeTypes, typePulse: PulseType) {
        resultWindow.updateCompletion?(bpm, date, analyzType, typePulse)
    }
    
    private func setupLayout() {
        darkView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        resultWindow.snp.makeConstraints { make in
            make.bottom.equalTo(20.adjusted)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(513.adjusted)
        }
    }
}

extension ResultScreenView: ResultWindowActionsDelegate {
    func tappedButtonOK() {
        self.removeFromSuperview()
        delegate?.saveToDBAndCloseResultView()
    }
}
