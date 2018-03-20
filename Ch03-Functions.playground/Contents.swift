// CHAPTER 03: FUNCTIONS

/// Setup
enum EmployeeType {
    case COMISSIONED
    case HOURLY
    case SALARIED
}
class Employee {
    let type: EmployeeType
    
    init(type: EmployeeType) {
        self.type = type
    }
}
class Money { }
func calculatedComissionedPay(_ employee: Employee) -> Money { return Money() }
func calculateHourlyPay(_ employee: Employee) -> Money { return Money() }
func calculateSalariedPay(_ employee: Employee) -> Money { return Money() }


//// ========== Problem ==========
/*
 When new employees are added, this function will grow
 It does more than one thing
 Violates Single Responsibility Princple - there is more than once reason for it to change
 Violates Open Closed Principle - it must change whenever new types are added.
 There are an unlimited number of other functions that will have the same structure.
 */
func calculatePay(e: Employee) throws -> Money {
    switch e.type {
    case .COMISSIONED:
        return calculatedComissionedPay(e)
    case .HOURLY:
        return calculateHourlyPay(e)
    case .SALARIED:
        return calculateSalariedPay(e)
    }
}

class EmployeeRecord {
    let type: EmployeeType
    
    init(type: EmployeeType) {
        self.type = type
    }
}
//// ========== Solution: Employee Factory ========== //
// Protocol name should really be `Employee`. Could not redeclare it
protocol EmployeeProtocol {
    func isPayday() -> Bool
    func calculatePay() -> Money
    func deliverPay(pay: Money)
}
protocol EmployeeFactory {
    func makeEmployee(r: EmployeeRecord) -> EmployeeProtocol
}

// Class implementations
class ComissionedEmployee: EmployeeProtocol {
    let employee: EmployeeRecord
    init(r: EmployeeRecord) { self.employee = r }
    func isPayday() -> Bool { return true }
    func calculatePay() -> Money { return Money() }
    func deliverPay(pay: Money) { }
}
class HourlyEmployee: EmployeeProtocol {
    let employee: EmployeeRecord
    init(r: EmployeeRecord) { self.employee = r }
    func isPayday() -> Bool { return true }
    func calculatePay() -> Money { return Money() }
    func deliverPay(pay: Money) { }
}
class SalariedEmployee: EmployeeProtocol {
    let employee: EmployeeRecord
    init(r: EmployeeRecord) { self.employee = r }
    func isPayday() -> Bool { return true }
    func calculatePay() -> Money { return Money() }
    func deliverPay(pay: Money) { }
}

// Factory Implemntation
class EmployeeFactoryImpl: EmployeeFactory {
    func makeEmployee(r: EmployeeRecord) -> EmployeeProtocol {
        switch r.type {
        case .COMISSIONED:
            return ComissionedEmployee(r: r)
        case .HOURLY:
            return HourlyEmployee(r: r)
        case .SALARIED:
            return SalariedEmployee(r: r)
        }
    }
}
