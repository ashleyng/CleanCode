//: Playground - noun: a place where people can play

class PrintPrimes {
    static func execute() {
        let M: Int = 1000
        let RR: Int = 50;
        let CC: Int = 4;
        let WW: Int = 10;
        let ORDMAX: Int = 30;
        var p:[Int] = [Int](repeating: 0, count: M + 1)
        var PAGENUMBER: Int
        var PAGEOFFSET: Int
//        var ROWOFFSET: Int
//        var C: Int
        var J: Int
        var K: Int
        var JPRIME: Bool
        var ORD: Int
        var SQUARE: Int
        var N: Int
        var MULT: [Int] = [Int](repeating: 0, count: ORDMAX + 1)
        
        J = 1
        K = 1
        p[1] = 2
        ORD = 2
        SQUARE = 9
        while K < M {
            repeat {
                J = J + 2
                if ( J == SQUARE) {
                    ORD = ORD + 1
                    SQUARE = p[ORD] * p[ORD]
                    MULT[ORD - 1] = J
                }
                N = 2
                JPRIME = true
                while N < ORD && JPRIME {
                    while MULT[N] < J {
                        MULT[N] = MULT[N] + p[N] + p[N]
                    }
                    if MULT[N] == J {
                        JPRIME = false
                    }
                    N = N + 1
                }
            } while !JPRIME
            K = K + 1
            p[K] = J
        }
        
        PAGENUMBER = 1
        PAGEOFFSET = 1
        while PAGEOFFSET <= M {
            print("The first \(M) prime numbers --- page \(PAGENUMBER)")
            for x in PAGEOFFSET..<PAGEOFFSET + RR {
                for y in 0..<CC {
                    if (x + y * RR <= M) {
                        print("\(p[x + y * RR])")
                    }
                }
            }
            PAGENUMBER = PAGENUMBER + 1
            PAGEOFFSET = PAGEOFFSET + RR * CC
        }
    }
}

PrintPrimes.execute()
