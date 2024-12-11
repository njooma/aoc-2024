//
//  Day11.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/11/24.
//

import Algorithms

struct Day11: AdventDay {
  var data: String

  func part1() -> Int {
    var stones = data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map(String.init)

    for _ in 0..<25 {
      var newStones = [String]()
      for stone in stones {
        if stone == "0" {
          newStones.append("1")
        } else if stone.count.isMultiple(of: 2) {
          let middle = stone.count/2
          let left = stone[stone.startIndex..<stone.index(stone.startIndex, offsetBy: middle)]
          let right = stone[stone.index(stone.startIndex, offsetBy: middle)...]
          newStones.append("\(Int(left)!)")
          newStones.append("\(Int(right)!)")
        } else {
          newStones.append("\(Int(stone)! * 2024)")
        }
      }
      stones = newStones
    }

    return stones.count
  }

  func part2() -> Int {
    var cache = [String: [String]]()
    let stones = data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map(String.init)
    var counts: [String: Int] = [:]
    for stone in stones {
      counts[stone, default: 0] += 1
    }

    for _ in 1..<76 {
      var newCounts = [String: Int]()
      for (stone, count) in counts {
        if let result = cache[stone] {
          for r in result {
            newCounts[r, default: 0] += count
          }
          continue
        }
        var result = [String]()
        if stone == "0" {
          result = ["1"]
        } else if stone.count.isMultiple(of: 2) {
          let middle = stone.count/2
          let left = stone[stone.startIndex..<stone.index(stone.startIndex, offsetBy: middle)]
          let right = stone[stone.index(stone.startIndex, offsetBy: middle)...]
          result = ["\(Int(left)!)", "\(Int(right)!)"]
        } else {
          result = ["\(Int(stone)! * 2024)"]
        }
        cache[stone] = result
        for r in result {
            newCounts[r, default: 0] += count
          }
      }
      counts = newCounts
    }

    return counts.values.reduce(0, +)
  }
}
