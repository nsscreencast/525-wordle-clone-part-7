import SwiftUI

final class GuessState: ObservableObject {

    private var word: String

    @Published var guessLetters: String = ""
    @Published private(set) var guesses: [Guess] = []
    @Published var didWin = false
    @Published var didLose = false

    init() {
        word = WordList.random
    }

    func reset() {
        didWin = false
        didLose = false
        guesses = []
        word = WordList.random
    }

    func validateGuess() {
        while guessLetters.count > 5 {
            guessLetters.removeLast()
        }

        guessLetters = guessLetters.trimmingCharacters(in: .letters.inverted)
    }

    func checkCompleteGuess() {
        if guessLetters.count == 5 {
            let guess = Guess.evaluate(guessLetters, against: word)
            guesses.append(guess)
            guessLetters = ""

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                if guess.isCorrect {
                    self.didWin = true
                } else if self.guesses.count == 6 {
                    self.didLose = true
                }
            }
        }
    }
}
