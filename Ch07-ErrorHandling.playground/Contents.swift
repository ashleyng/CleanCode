//: CHAPTER 07: Error Handling
import Foundation


//// ========== Problem ==========
/*
 Not super swift, but resemebles the example code in the book well.
 Problem is that the caller must check for error immediately after the call.
 Really easy to forget to do this.
 */
enum DeviceHandle {
    case invalid
    
    func getRecord() -> Record {
        return Record()
    }
}
struct Record {
    public enum RecordStatus {
        case deviceSuspended
    }
    func getStatus() -> RecordStatus {
        return RecordStatus.deviceSuspended
    }
}
class DeviceControllerProblem {
    var record: Record!
    
    func sendShutDown() {
        let handle: DeviceHandle = getHandle()
        // check status of device
        if handle != DeviceHandle.invalid {
            // Save the device status to the record field
            retrieveDeviceRecord(handle)
            // If not suspended, shut down
            if record.getStatus() != Record.RecordStatus.deviceSuspended {
                pauseDevice()
                clearDeviceWorkQueue(handle: handle)
                closeDevice(handle: handle)
            } else {
                print("Device suspended. Unable to shut down")
            }
        } else {
            print("Invalid handle for device")
        }
    }
    
    func getHandle() -> DeviceHandle {
        return DeviceHandle.invalid
    }
    
    func retrieveDeviceRecord(_ handle: DeviceHandle) {
        record = Record()
    }
    
    func pauseDevice() { }
    func clearDeviceWorkQueue(handle: DeviceHandle) { }
    func closeDevice(handle: DeviceHandle) { }
}

//// ========== Solution ==========
/*
 This code also seperates out two concerns: the algorithm for
 device shutdown and error handling.
 */
class DeviceControllerSolution {
    
    enum CustomError: Error {
        case deviceShutDownError
        
        var description: String {
            switch self {
            case .deviceShutDownError:
                return "DeviceShutDownError"
            }
        }
    }
    
    func sendShutDown() {
        do {
            try tryToShutdown()
        } catch let error {
            if let customError = error as? CustomError {
                print("Error: \(customError.description)")
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tryToShutdown() throws {
        let handle: DeviceHandle = try getHandle()
        let record: Record = retrieveDeviceRecord(handle)
        
        pauseDevice()
        clearDeviceWorkQueue(handle: handle)
        closeDevice(handle: handle)
    }
    
    func getHandle() throws -> DeviceHandle {
        throw CustomError.deviceShutDownError
        return DeviceHandle.invalid
    }
    func retrieveDeviceRecord(_ handle: DeviceHandle) -> Record {
        return Record()
    }
    func pauseDevice() { }
    func clearDeviceWorkQueue(handle: DeviceHandle) { }
    func closeDevice(handle: DeviceHandle) { }
}

/// ========== Problem ==========
/*
 There are three different errors types in this code
 */
enum DeviceResponseError: Error {
    case error
}
enum ATM1212UnlockedError: Error {
    case error
}
enum GMXError: Error {
    case error
}
struct ACMEPort {
    let rand = arc4random_uniform(100)
    let portNumber: Int
    init(portNumber: Int) { self.portNumber = portNumber }
    func open() throws {
        if rand < 33 {
            throw DeviceResponseError.error
        } else if rand < 66 && rand >= 33 {
            throw ATM1212UnlockedError.error
        } else {
            throw GMXError.error
        }
    }
}
do {
    try ACMEPort(portNumber: 123).open()
} catch _ as DeviceResponseError {
    print("Device Response Error")
} catch _ as ATM1212UnlockedError {
    print("Unlock Error")
} catch _ as GMXError {
    print("Device Response Error")
}

//// ========== Solution ==========
/*
 Translate those exceptions into a common exception type.
 */
enum PortDeviceFailure: Error {
    case portDeviceFailure(error: Error)
    
    var description: String {
        switch self {
        case .portDeviceFailure(let error):
            return error.localizedDescription
        }
    }
}
struct LocalPort {
    private let innerPort: ACMEPort
    
    init(portNumber: Int) {
        innerPort = ACMEPort(portNumber: portNumber)
    }
    
    func open() throws {
        do {
            try innerPort.open()
        } catch let error as DeviceResponseError {
            throw PortDeviceFailure.portDeviceFailure(error: error)
        } catch let error as ATM1212UnlockedError {
            throw PortDeviceFailure.portDeviceFailure(error: error)
        } catch let error as GMXError {
            throw PortDeviceFailure.portDeviceFailure(error: error)
        }
    }
}


//// ========== Problem ==========
/*
 The exception in the do-catch block
 at the bottom clutters the logic.
 */
struct MealExpenseProblem {
    func getTotal() -> Double {
        return 123.12
    }
}
class MealExpenseReportThrow {
    enum CustomError: Error {
        case mealExpenseNotFound
    }
    static func getMeals(employeeId: Int) throws -> MealExpenseProblem {
        if employeeId % 2 == 0 {
            return MealExpenseProblem()
        }
        throw CustomError.mealExpenseNotFound
    }
    
}

func getMealPerDiem() -> Double { return 45.0 }
var totalProblem: Double = 0
do {
    let expenses = try MealExpenseReportThrow.getMeals(employeeId: 123)
    totalProblem += expenses.getTotal()
} catch _ as MealExpenseReportThrow.CustomError {
    totalProblem += getMealPerDiem()
}

//// ========== Solution ==========
/*
 Special Case Pattern
 You create a class or configure an object so that it
 handles a special case for you
 */
protocol MealExpenseSolution {
    func getTotal() -> Int
}
class MealExpenseReport {
    enum CustomError: Error {
        case mealExpenseNotFound
    }
    static func getMeals(employeeId: Int) -> MealExpenseSolution {
        // this would of course return per diem or the expense solution
        return PerDiemMealExpenses()
    }
    
}
class PerDiemMealExpenses: MealExpenseSolution {
    func getTotal() -> Int {
        return 45
    }
}
var totalSolution: Int = 0
let expenses = MealExpenseReport.getMeals(employeeId: 1234)
// Per Diam is handled in the call to get Total
totalSolution += expenses.getTotal()
