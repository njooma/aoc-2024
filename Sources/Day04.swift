//
//  Day04.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/4/24.
//

import Algorithms

struct Day04: AdventDay {
  var data: String

  var lines: [[String]] {
    data.split(separator: "\n").map { $0.split(separator: "").map(String.init) }
  }

  enum Direction: CaseIterable {
    case north, northEast, east, southEast, south, southWest, west, northWest

    var delta: (Int, Int) {
      return switch self {
      case .north: (-1, 0)
      case .northEast: (-1, 1)
      case .east: (0, 1)
      case .southEast: (1, 1)
      case .south: (1, 0)
      case .southWest: (1, -1)
      case .west: (0, -1)
      case .northWest: (-1, -1)
      }
    }
  }

  func part1() -> Int {
    let nextLetter = [
      "X": "M",
      "M": "A",
      "A": "S",
    ]

    func checkDirection(
      startCol i: Int, startRow j: Int, direction: Direction, letterToFind x: String
    ) -> Bool {
      let nextI = i + direction.delta.0
      let nextJ = j + direction.delta.1
      if !(nextI >= 0 && nextJ >= 0 && nextI < lines.count && nextJ < lines[nextI].count) {
        return false
      }
      let char = lines[nextI][nextJ]
      if char == x {
        if let nextChar = nextLetter[x] {
          return checkDirection(
            startCol: nextI, startRow: nextJ, direction: direction,
            letterToFind: nextChar)
        }
        return true
      }
      return false
    }

    var output = 0
    for (i, line) in lines.enumerated() {
      for (j, char) in line.enumerated() {
        if char == "X" {
          var cases: [Bool] = []
          for dir in Direction.allCases {
            cases.append(
              checkDirection(
                startCol: i, startRow: j, direction: dir, letterToFind: "M"))
          }
          output += cases.count { $0 }
        }
      }
    }
    return output
  }

  func part2() -> Int {
    var output = 0
    for i in 1..<lines.count - 1 {
      let line = lines[i]
      for j in 1..<line.count - 1 {
        let char = line[j]

        if char != "A" {
          continue
        }

        // Check NW to SE first
        var newI = i + Direction.northWest.delta.0
        var newJ = j + Direction.northWest.delta.1
        var newChar = lines[newI][newJ]
        if newChar == "M" {
          newI = i + Direction.southEast.delta.0
          newJ = j + Direction.southEast.delta.1
          newChar = lines[newI][newJ]
          if newChar != "S" {
            continue
          }
        } else if newChar == "S" {
          newI = i + Direction.southEast.delta.0
          newJ = j + Direction.southEast.delta.1
          newChar = lines[newI][newJ]
          if newChar != "M" {
            continue
          }
        } else {
          continue
        }

        // Check NE to SW next
        newI = i + Direction.northEast.delta.0
        newJ = j + Direction.northEast.delta.1
        newChar = lines[newI][newJ]
        if newChar == "M" {
          newI = i + Direction.southWest.delta.0
          newJ = j + Direction.southWest.delta.1
          newChar = lines[newI][newJ]
          if newChar != "S" {
            continue
          }
        } else if newChar == "S" {
          newI = i + Direction.southWest.delta.0
          newJ = j + Direction.southWest.delta.1
          newChar = lines[newI][newJ]
          if newChar != "M" {
            continue
          }
        } else {
          continue
        }
        output += 1
      }
    }
    return output
  }
}
