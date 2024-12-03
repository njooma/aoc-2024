//
//  Day01.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/2/24.
//

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var list1: [Int] {
    return data.split(separator: "\n").map { line in
      return line.split(separator: " ").map { i in
        return Int(i.trimmingCharacters(in: .whitespaces))!
      }[0]
    }
  }

  var list2: [Int] {
    return data.split(separator: "\n").map { line in
      return line.split(separator: " ").map { i in
        return Int(i.trimmingCharacters(in: .whitespaces))!
      }[1]
    }
  }

  func part1() -> Int {
    let l1 = list1.sorted()
    let l2 = list2.sorted()
    let l = zip(l1, l2)
    return l.map { abs($0.0 - $0.1) }.reduce(0, +)
  }

  func part2() -> Int {
    var m1 = [Int: Int]()
    var m2 = [Int: Int]()
    
    list1.forEach {
      m1[$0, default: 0] += 1
    }
    list2.forEach {
      m2[$0, default: 0] += 1
    }
    
    var output = 0
    m1.forEach {
      let multiplier = $0.value * m2[$0.key, default: 0]
      output += $0.key * multiplier
    }
    return output
  }
}
