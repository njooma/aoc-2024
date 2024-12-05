//
//  Day05.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/5/24.
//

import Algorithms

struct Day05: AdventDay {
  var data: String

  var rules: [Int: Set<Int>] {
    var output = [Int: Set<Int>]()
    data.split(separator: "\n\n")[0].split(separator: "\n").forEach { rule in
      let key = rule.split(separator: "|")[0]
      let value = rule.split(separator: "|")[1]
      output[Int(key)!, default: Set<Int>()].insert(Int(value)!)
    }
    return output
  }

  var updates: [[Int]] {
    let updateSection = data.split(separator: "\n\n")[1]
    return updateSection.split(separator: "\n").map { $0.split(separator: ",").map { Int($0)! } }
  }

  func part1() -> Int {
    var output = 0
    for update in updates {
      if update.count % 2 == 0 {
        continue
      }
      var isValid = true
      for i in 0..<update.count {
        let curr = update[i]
        let mustComeAfter = rules[curr] ?? []
        let before = update[0..<i]
        if !mustComeAfter.intersection(before).isEmpty {
          isValid = false
          break
        }
      }
      if isValid {
        output += update[update.count / 2]
      }
    }
    return output
  }

  func part2() -> Int {
    var output = 0
    for i in 0..<updates.count {
      var update = updates[i]
      var wasBad = false
      var j = 0
      while j <= update.count - 1 {
        let curr = update[j]
        let mustComeAfter = rules[curr] ?? []
        var before = update[0..<j]
        let badBefore = mustComeAfter.intersection(before)
        if !wasBad {
          wasBad = !badBefore.isEmpty
        }
        let store = update
        before.removeAll { badBefore.contains($0) }
        update = Array(before)
        update.append(contentsOf: store[j..<store.count])
        update.append(contentsOf: badBefore)
        j = j - badBefore.count + 1
      }
      output += wasBad ? update[update.count / 2] : 0
    }
    return output
  }
}
