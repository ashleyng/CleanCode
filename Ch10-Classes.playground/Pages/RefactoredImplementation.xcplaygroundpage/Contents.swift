//: [Previous](@previous)

class PrimePrinter {
    static func execute() {
        let NUMBER_OF_PRIMES = 1000
        let primes: [Int] = PrimeGenerator(NUMBER_OF_PRIMES).generate()
        
        let ROWS_PER_PAGE = 50
        let COLUMNS_PER_PAGE = 4
        let tablePrinter: RowColumnPagePrinter = RowColumnPagePrinter(ROWS_PER_PAGE,
                                                                      COLUMNS_PER_PAGE,
                                                                      "The first \(NUMBER_OF_PRIMES) prime numbers")
        tablePrinter.printData(data: primes)
    }
}

class RowColumnPagePrinter {
    private let rowsPerPage: Int
    private let columnsPerPage: Int
    private let numbersPerPage: Int
    private let pageHeader: String
    
    init(_ rowsPerPage: Int, _ columnsPerPage: Int, _ pageHeader: String) {
        self.rowsPerPage = rowsPerPage
        self.columnsPerPage = columnsPerPage
        self.pageHeader = pageHeader
        numbersPerPage = rowsPerPage * columnsPerPage
    }
    
    func printData(data: [Int]) {
        var pageNumber = 1
        for x in stride(from: 0, to: data.count, by: numbersPerPage) {
            let lastIndexOnPage = min(x + numbersPerPage - 1, data.count - 1)
            printPageHeader(pageHeader, pageNumber)
            printPage(x, lastIndexOnPage, data)
            pageNumber += 1
        }
    }
    
    private func printPage(_ firstIndexOnPage: Int, _ lastIndexOnPage: Int, _ data: [Int]) {
        let firstIndexOfLastRowOnPage = firstIndexOnPage + rowsPerPage - 1
        for x in firstIndexOnPage...firstIndexOfLastRowOnPage {
            printRow(x, lastIndexOnPage, data)
        }
    }
    
    private func printRow(_ firstIndexInRow: Int, _ lastIndexOnPage: Int, _ data: [Int]) {
        for x in 0..<columnsPerPage {
            let index = firstIndexInRow + x * rowsPerPage
            if index <= lastIndexOnPage {
                print("\(data[index])")
            }
        }
    }
    
    private func printPageHeader(_ pageHeader: String, _ pageNumber: Int) {
        print("\(pageHeader) --- Page \(pageNumber)")
        
    }
}

class PrimeGenerator {
    private var primes: [Int]
    private var multiplesOfPrimeFactors: [Int]
    
    init(_ n: Int) {
        primes = [Int](repeating: 0, count: n)
        multiplesOfPrimeFactors = []
        
    }
    
    func generate() -> [Int] {
        set2AsFirstPrime()
        checkOddNumbersForSubsequentPrimes()
        return primes
    }
    
    private func set2AsFirstPrime() {
        primes[0] = 2
        multiplesOfPrimeFactors.append(2)
    }
    
    private func checkOddNumbersForSubsequentPrimes() {
        var primeIndex = 1
        var x = 3
        while primeIndex < primes.count {
            if isPrime(x) {
                primes[primeIndex] = x
                primeIndex += 1
            }
            x += 2
        }
    }
    
    private func isPrime(_ candidate: Int) -> Bool {
        if isLeastRelevantMultipleOfNextLargerPrimeFactor(candidate) {
            multiplesOfPrimeFactors.append(candidate)
            return false
        }
        return isNotMultipleOfAnyPreviousPrimeFactor(candidate)
    }
    
    private func isLeastRelevantMultipleOfNextLargerPrimeFactor(_ candidate: Int) -> Bool {
        let nextLargerPrimeFactor = primes[multiplesOfPrimeFactors.count]
        let leastRelevantMultiple = nextLargerPrimeFactor * nextLargerPrimeFactor
        return candidate == leastRelevantMultiple
    }
    
    private func isNotMultipleOfAnyPreviousPrimeFactor(_ candidate: Int) -> Bool {
        for x in 1..<multiplesOfPrimeFactors.count {
            if (isMultipleOfNthPrimeFactor(candidate, x)) {
                return false
            }
        }
        return true
    }
    
    private func isMultipleOfNthPrimeFactor(_ candidate: Int, _ n: Int) -> Bool {
        return candidate == smallestOddNthMultipleNotLessThanCandidate(candidate, n)
    }
    
    private func smallestOddNthMultipleNotLessThanCandidate(_ candidate: Int, _ n: Int) -> Int {
        var multiple = multiplesOfPrimeFactors[n]
        while multiple < candidate {
            multiple += 2 * primes[n]
        }
        multiplesOfPrimeFactors[n] = multiple
        return multiple
    }
    
}

PrimePrinter.execute()
//: [Next](@next)
