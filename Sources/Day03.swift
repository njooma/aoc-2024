//
//  Day03.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/3/24.
//

import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Int {
    let regex = /mul\(\d{1,3},\d{1,3}\)/
    var output = 0
    let matches = data.matches(of: regex)
    for match in matches {
      let mul = data[match.range]
      output += mul.dropFirst(4).dropLast().split(separator: ",").map { Int($0)! }.reduce(1, *)
    }
    return output
  }

  func part2() -> Int {
    func mathRegex(_ line: String) -> Int {
      let regex = /mul\(\d{1,3},\d{1,3}\)/
      var output = 0
      let matches = line.matches(of: regex)
      for match in matches {
        let mul = line[match.range]
        output += mul.dropFirst(4).dropLast().split(separator: ",").map { Int($0)! }.reduce(1, *)
      }
      return output
    }

    var output = 0
    var enabled = true
    let dont = /don't\(\)/
    let doreg = /do\(\)/

    var testLine = data
    while !testLine.isEmpty {
      var match: Regex<Substring>.Match?
      if enabled {
        match = testLine.firstMatch(of: dont)
      } else {
        match = testLine.firstMatch(of: doreg)
      }

      let endIdx = match?.endIndex ?? testLine.endIndex

      if enabled {
        output += mathRegex(String(testLine[..<endIdx]))
      }

      enabled.toggle()
      testLine = String(testLine[endIdx..<testLine.endIndex])
    }
    return output
  }
}
