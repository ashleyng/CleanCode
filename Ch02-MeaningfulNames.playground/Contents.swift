// CHAPTER 02: MEANINGFUL NAMES

//// ========== Intention Revealing Names ==========
//// ========== Problem 1 ==========
/* this name reveals nothing. It does not
envoke a sense of elapsed time, nor days. */
var d = 3 // elapsed time in days

//// ========== Solution 1 ==========
var elapsedTimeInDays = 3
var daysSinceCreation = 3
var daysSinceModification = 3
var fileAgeInDays = 3

//// ========== Problem 2 ==========
// Setup
let theList = [[Int]]()

// Example function
func getThem() -> [[Int]] {
    var list = [[Int]]()
    for x in theList { // what is theList?
        if x[0] == 4 { // why is the zeroth subscript important? Why 4?
            list.append(x)
        }
    }
    return list // how would I use this list being returned?
}

//// ========== Solution 2.1 ==========
// Setup
let gameBoard = [[Int]]()
let STATUS_VALUE_INDEX = 0
let FLAGGED = 0

// Example function
func getFlaggedCells() -> [[Int]] {
    var flaggedCells = [[Int]]()
    for cell in gameBoard {
        if (cell[STATUS_VALUE_INDEX] == FLAGGED) {
            flaggedCells.append(cell)
        }
    }
    return flaggedCells
}

//// ========== Solution 2.2 ==========
// Setup
struct Cell {
    let STATUS_VALUE_INDEX = 0
    let a = [Bool]()
    func isFlagged() -> Bool {
        return a[STATUS_VALUE_INDEX]
    }
}
let gameBoard2 = [Cell]()

// Example function
func getFlaggedCells2() -> [Cell] {
    var flaggedCells = [Cell]()
    for cell in gameBoard2 {
        if cell.isFlagged() {
            flaggedCells.append(cell)
        }
    }
    return flaggedCells
}

//// ========== Searchable Names ==========
//// ========== Problem ==========
/* What this code is doing isn't very
clear based on the varible names used */
var s = 0
let t = [Int](repeatElement(1, count: 34))
for x in 0..<34{
    s += (t[x]*4)/5
}

//// ========== Soltion ==========
let taskEstimate = [Int](repeatElement(1, count: 34))
let realDaysPerIdealDay = 4
let WORK_DAYS_PER_WEEK = 5
var sum = 0
for x in 0..<34 {
    let realTaskDays = taskEstimate[x] * realDaysPerIdealDay
    let realTaskWeeks = (realTaskDays / WORK_DAYS_PER_WEEK)
    sum += realTaskWeeks
}


//// ========== Meaningful Context ==========
//// ========== Problem ==========
/* The function name proves only part of the context; the algorithm provies the rest
When you first look at the method, the meanings of the variables are opaque */
private func printGuessStatistics(candidate: String, count: Int) {
    var number: String
    var verb: String
    var pluralModifier: String
    if count == 0 {
        number = "no"
        verb = "are"
        pluralModifier = "s"
    } else if count == 1 {
        number = "1"
        verb = "is"
        pluralModifier = ""
    } else {
        number = "\(count)"
        verb = "are"
        pluralModifier = "s"
    }
    let guessMessage = "There \(verb) \(number) \(candidate)\(pluralModifier)"
    print(guessMessage)
}
print("===== Problem: Meaningful Context =====")
printGuessStatistics(candidate: "Apple", count: 0)
printGuessStatistics(candidate: "Apple", count: 1)
printGuessStatistics(candidate: "Apple", count: 5)

//// ========== Solution ==========
class GuessStatisticsMessage {
    private var number: String = ""
    private var verb: String = ""
    private var pluralModifier: String = ""
    
    public func make(candidate: String, count: Int) -> String {
        createPluralDependentMessageParts(count: count)
        return "There \(verb) \(number) \(candidate)\(pluralModifier)"
    }
    
    private func createPluralDependentMessageParts(count: Int) {
        if count == 0 {
            thereAreNoLetters()
        } else if count == 1 {
            thereIsOneLetter()
        } else {
            thereAreManyLetters(count)
        }
    }
    
    private func thereAreManyLetters(_ count: Int) {
        self.number = "\(count)"
        self.verb = "are"
        self.pluralModifier = "s"
    }
    
    private func thereIsOneLetter() {
        self.number = "1"
        self.verb = "is"
        self.pluralModifier = ""
    }
    
    private func thereAreNoLetters() {
        self.number = "no"
        self.verb = "are"
        self.pluralModifier = "s"
    }
}
print("===== Solution: Meaningful Context =====")
print(GuessStatisticsMessage().make(candidate: "Orange", count: 0))
print(GuessStatisticsMessage().make(candidate: "Orange", count: 1))
print(GuessStatisticsMessage().make(candidate: "Orange", count: 5))

//// ========== Swifty Solution ==========
class GuessStatisticsMessageSwift {
    private var number: String!
    private var verb: String!
    private var pluralModifier: String!
    private let candidate: String
    
    init(candidate: String, count: Int) {
        self.candidate = candidate
        createPluralDependentMessageParts(count: count)
    }
    
    public func make() -> String {
        return "There \(verb!) \(number!) \(candidate)\(pluralModifier!)"
    }
    
    private func createPluralDependentMessageParts(count: Int) {
        if count == 0 {
            thereAreNoLetters()
        } else if count == 1 {
            thereIsOneLetter()
        } else {
            thereAreManyLetters(count)
        }
    }
    
    private func thereAreManyLetters(_ count: Int) {
        self.number = "\(count)"
        self.verb = "are"
        self.pluralModifier = "s"
    }
    
    private func thereIsOneLetter() {
        self.number = "1"
        self.verb = "is"
        self.pluralModifier = ""
    }
    
    private func thereAreNoLetters() {
        self.number = "no"
        self.verb = "are"
        self.pluralModifier = "s"
    }
}
print("===== Swifty Solution: Meaningful Context =====")
let zeroBanana = GuessStatisticsMessageSwift(candidate: "Banana", count: 0)
print(zeroBanana.make())
let oneBanana = GuessStatisticsMessageSwift(candidate: "Banana", count: 1)
print(oneBanana.make())
let manyBanana = GuessStatisticsMessageSwift(candidate: "Banana", count: 5)
print(manyBanana.make())
