// CHAPTER 06: OBJECTS AND DATA STRUCTURES


//// ========== Problem ==========
/*
 very clearly in rectangular coordinates and forces us to
 manipulte those coordinates independently
 this exposes implementation
 */
public struct PointClass {
    var x: Double
    var y: Double
}

//// ========== Solution ========== //
/*
 You can't tell whether the implementation is
 in a rectangle or polar coordinates
 Enforces access policy and can read the data independently
 But you must set the coordinates together
 */
public protocol PointProtocol {
    func getX() -> Double
    func getY() -> Double
    func setCartesian(x: Double, y: Double)
    func getR() -> Double
    func getTheta() -> Double
    func setPolar(r: Double, theta: Double)
}


//// ========== Problem ==========
// Uses concrete terms to communicate the fuel level (Gallons)
public protocol Vehicle_One {
    func getFuelTankCapacityInGallons() -> Double
    func getFallonsOfGasolin() -> Double
}

//// ========== Solution ========== //
/*
 Abstracts to percentage, you don't know the form of the data
 you don't want to expose the details of the data
 express our data in abstract terms
 */
public protocol Vehicle_Two {
    func getPercentFuelRemaining() -> Double
}


//// ========== Procedural Shape ==========
// Setup
public struct Point {
    var x: Double
    var y: Double
}
enum CustomError: Error {
    case NoSuchShape
}

/*
 Simple data structures without any behavior
 all behavior is in the Geometry class
 */
public class Square {
    var topLeft: Point
    var side: Double
    init(topLeft: Point, side: Double) {
        self.topLeft = topLeft
        self.side = side
    }
}
public class Rectangle {
    var topLeft: Point
    var height: Double
    var length: Double
    init(topLeft: Point, height: Double, length: Double) {
        self.topLeft = topLeft
        self.height = height
        self.length = length
    }
}
public class Circle {
    var center: Point
    var radius: Double
    init(center: Point, radius: Double) {
        self.center = center
        self.radius = radius
    }
}
/*
 If you add a perimeter() function, the shape classes would
 be unaffected. On the other hand, if a shape is added, functions in
 Geometry must change to deal with it.
 */
public struct Geometry {
    func area(shape: AnyObject) throws -> Double {
//        if let square = shape as Square {
//            return square.side * square.side
//        } else if let rectange = shape as Rectangle {
//            return rectange.height * rectange.length
//        } else if let circle = shape as Circle {
//            return Double.pi * circle.radius * circle.radius
//        }
        throw CustomError.NoSuchShape
    }
}

//// ========== Polymorphic Shape ==========
// Setup
/*
 area() is polymorphic, no Geometry class is necessary.
 So if a new shape is added, none of the existing functions
 are affected, but if a new function is added all the
 shapes must change
 */
public protocol Shape {
    func area() -> Double
}
public struct SquareImpl: Shape {
    private let topLeft: Point
    private let side: Double
    
    public func area() -> Double {
        return side * side
    }
}
public struct RectangleImpl: Shape {
    private let topLeft: Point
    private let height: Double
    private let width: Double
    
    public func area() -> Double {
        return height * width
    }
}
public struct CircleImpl: Shape {
    private let center: Point
    private let radius: Double
    
    public func area() -> Double {
        return Double.pi * radius * radius
    }
}

//// ========== "Bean" form. DTO ==========
// Have private variables manipulted by getters and setters
public class Address {
    private let street: String
    private let streetExtra: String
    private let city: String
    private let state: String
    private let zip: String
    
    init(street: String, streetExtra: String, city: String, state: String, zip: String) {
        self.street = street
        self.streetExtra = streetExtra
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    func getStreet() -> String {
        return street
    }
    
    func getStreetExtra() -> String {
        return streetExtra
    }
    
    func getCity() -> String {
        return city
    }
    
    func getState() -> String {
        return state
    }
    
    func getZip() -> String {
        return zip
    }
}
