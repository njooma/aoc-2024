//
//  Day02.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/2/24.
//

import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var entities: [[Int]] {
    data.split(separator: "\n").map { $0.split(separator: " ").compactMap { Int($0)! } }
  }

  func part1() -> Int {
    var output = 0
    for report in entities {
      let isIncreasing = report[0] < report[1]
      var isSafe = false
      for pair in report.adjacentPairs() {
        isSafe = false
        let diff = pair.0 - pair.1
        if diff == 0 {
          break
        }
        if diff < 0 {
          if !isIncreasing {
            break
          }
        } else if diff > 0 {
          if isIncreasing {
            break
          }
        }

        let absDiff = abs(diff)
        if absDiff < 1 || absDiff > 3 {
          break
        }
        isSafe = true
      }
      output += isSafe ? 1 : 0
    }
    return output
  }

  func part2() -> Int {
    func test(report: [Int]) -> (Bool, Int?) {
      let isIncreasing = report[0] < report[1]
      var isSafe = false
      var problemSpot: Int? = nil
      for (idx, pair) in report.adjacentPairs().enumerated() {
        isSafe = false
        let diff = pair.0 - pair.1
        if diff == 0 {
          problemSpot = idx
          break
        }
        if diff < 0 {
          if !isIncreasing {
            problemSpot = idx
            break
          }
        } else if diff > 0 {
          if isIncreasing {
            problemSpot = idx
            break
          }
        }

        let absDiff = abs(diff)
        if absDiff < 1 || absDiff > 3 {
          problemSpot = idx
          break
        }
        isSafe = true
      }
      return (isSafe, problemSpot)
    }

    var output = 0
    for report in entities {
      var (isSafe, problemSpot) = test(report: report)

      if !isSafe {
        var r0 = report
        var r1 = report
        var r2 = report
        var safeArray: [Bool] = []

        if problemSpot != 0 {
          r0.remove(at: problemSpot! - 1)
          let (s0, _) = test(report: r0)
          safeArray.append(s0)
        }
        r1.remove(at: problemSpot!)
        r2.remove(at: problemSpot! + 1)

        let (s1, _) = test(report: r1)
        let (s2, _) = test(report: r2)
        safeArray.append(contentsOf: [s1, s2])

        isSafe = safeArray.contains(true)
      }
      if !isSafe { print(report) }
      output += isSafe ? 1 : 0
    }
    return output
  }
}
