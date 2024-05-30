
import UIKit
import SnapKit

final class TestsQuestionsViewController: UIViewController {
    
    let tableViewController = UITableViewController(style: .plain)
    private let lettersArr = ["a.", "b.", "c.", "d."]
    private let textArr = ["Never or jccasionally ", "Sometimes", "Often ", "Almost always or constantly"]
    private let questionsArr = ["I fell depressed",
                        "Little interest or pleasure in doing things",
                        "Feeling down, depressed, or hopeless",
                        "Feeling tired or having little energy",
                        "Poor appetite or overeating",
                        "I generally feel down and unhappy",
                        "I have less interest in other people than I used to",
                        "I easily get impatient, frustrated, or angry with people",
                        "I feel like I have nothing to look forward to",
                        "I have episodes of crying that are hard to stop"
    ]
    
    private var currentQuestionIndex = 0
    
    //Сохраняем вычесленное расстояние для перемещения треугольника
    private var distanceForTriangle = 0

    private lazy var countPagesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        label.text = "1/10"
        
        view.addSubview(label)
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left-black-arrow-image"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.textColor = .black
        label.text = "I feel depressed"
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        return label
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
        
        createTableView()
    }
    
    //MARK: Создание tableView
    private func createTableView() {
        tableViewController.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        tableViewController.tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionTableViewCell")
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        tableViewController.tableView.separatorStyle = .none
        tableViewController.tableView.allowsMultipleSelection = false
        
        view.addSubview(tableViewController.tableView)
    }
    
    @objc func goBackAction() {
        self.dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension TestsQuestionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lettersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
        
        let itemLetter = lettersArr[indexPath.row]
        let itemTextArr = textArr[indexPath.row]
        
        cell.letterLabel.text = itemLetter
        cell.descriptionLabel.text = itemTextArr
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension TestsQuestionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is QuestionTableViewCell else { return }
        
        //Создаем расстояние для перемещения треугольника результата
        distanceForTriangle += indexPath.row * 12
        
        if currentQuestionIndex < questionsArr.count - 1 {
            currentQuestionIndex += 1
            titleLabel.text = questionsArr[currentQuestionIndex]
            countPagesLabel.text = "\(currentQuestionIndex + 1)/\(questionsArr.count)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tableView.reloadData()
            }

        } else {
            let nextVC = TestResultViewController()
            nextVC.distanceForTriangle = distanceForTriangle
            
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
}

//MARK: - Constraints
extension TestsQuestionsViewController {
    private func setupLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(18)
        }
        
        countPagesLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.top.equalTo(countPagesLabel.snp.bottom).offset(30)
            make.trailing.equalTo(-18)
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(300)
        }
    }
}
