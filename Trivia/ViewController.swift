import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    var questions: [Question] = [
        Question(questionText: "What's 2 + 2?", answers: ["2", "4", "6", "8"], correctAnswerIndex: 1),
        Question(questionText: "Capital of France?", answers: ["Berlin", "Madrid", "Paris", "Lisbon"], correctAnswerIndex: 2),
        Question(questionText: "Which one is a fruit?", answers: ["Apple", "Carrot", "Potato", "Onion"], correctAnswerIndex: 0)
    ]
    
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()
    }
    
    func loadQuestion() {
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.questionText
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
        }
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = answerButtons.firstIndex(of: sender) else { return }
        let question = questions[currentQuestionIndex]
        if buttonIndex == question.correctAnswerIndex {
            // Correct
            score += 1
        }
        // Move to next question or finish
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
            loadQuestion()
        } else {
            finishQuiz()
        }
    }
    
    func finishQuiz() {
        let alert = UIAlertController(title: "Done!", message: "You got \(score)/\(questions.count) correct!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartQuiz()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func restartQuiz() {
        score = 0
        currentQuestionIndex = 0
        loadQuestion()
    }
}
