//
//  Day07.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/9/24.
//

import Algorithms

struct Day07: AdventDay {
  var data: String

  var equations: [(Int, [Int])] {
    return data.split(separator: "\n").map {
      let result = $0.split(separator: ":")[0]
      let inputs = $0.split(separator: ":")[1]
      return (
        Int(result.trimmingCharacters(in: .whitespacesAndNewlines))!,
        inputs.split(separator: " ").map {
          Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
        }
      )
    }
  }

  func getAllOperators(operators: [String], count: Int) -> [[String]] {
    let allOperators = Array(repeating: operators, count: count - 1)
    var result = operators.map { [$0] }
    for ops in allOperators {
      result = cartesian(a: result, b: ops)
    }
    return result
  }

  func cartesian(a: [[String]], b: [String]) -> [[String]] {
    var res = [[String]]()
    for i in a {
      for j in b {
        var temp = i
        temp.append(j)
        res.append(temp)
      }
    }
    return res
  }

  func part1() -> Int {
    var output = 0
    for (result, inputs) in equations {
      let operators = getAllOperators(operators: ["+", "*"], count: inputs.count - 1)
      for opList in operators {
        var curr = inputs[0]
        for (idx, op) in opList.enumerated() {
          if op == "+" {
            curr += inputs[idx + 1]
          } else if op == "*" {
            curr *= inputs[idx + 1]
          }
        }
        if curr == result {
          output += result
          break
        }
      }
    }
    return output
  }

  func part2() -> Int {
    var output = 0
    for (result, inputs) in equations {
      let operators = getAllOperators(operators: ["+", "*", "||"], count: inputs.count - 1)
      for opList in operators {
        var curr = inputs[0]
        for (idx, op) in opList.enumerated() {
          if op == "+" {
            curr += inputs[idx + 1]
          } else if op == "*" {
            curr *= inputs[idx + 1]
          } else if op == "||" {
            curr = Int("\(curr)\(inputs[idx+1])")!
          }
        }
        if curr == result {
          output += result
          break
        }
      }
    }
    return output
  }
}
