//
//  Day06.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/6/24.
//

import Algorithms

struct Day06: AdventDay {
  var data: String

  var map: [[String]] {
    return self.data.split(separator: "\n").map { $0.split(separator: "").map(String.init) }
  }

  enum Direction: String {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"
  }

  func getStart() -> (Int, Int, Direction) {
    for i in 0..<map.count {
      let row = map[i]
      for j in 0..<row.count {
        if let dir = Direction(rawValue: row[j]) {
          return (i, j, dir)
        }
      }
    }
    fatalError("Could not find start")
  }

  func generateMap() -> [[String]] {
    var (i, j, direction) = getStart()

    var markedMap = map
    var marker = direction
    while true {
      markedMap[i][j] = "X"

      var nextI = i
      var nextJ = j
      switch marker {
      case .up: nextI -= 1
      case .down: nextI += 1
      case .left: nextJ -= 1
      case .right: nextJ += 1
      }

      if nextI < 0 || nextI >= map.count || nextJ < 0 || nextJ >= map[nextI].count {
        break
      }

      if map[nextI][nextJ] == "#" {
        marker =
          switch marker {
          case .up: .right
          case .right: .down
          case .down: .left
          case .left: .up
          }
      } else {
        i = nextI
        j = nextJ
      }
    }
    return markedMap
  }

  func part1() -> Int {
    let markedMap = generateMap()
    return markedMap.joined().joined().count { $0 == "X" }
  }

  func part2() -> Int {
    var output = 0

    let start = getStart()
    func testIsLoop(map: [[String]]) -> Bool {
      var (i, j, direction) = start

      var visited: [(Int, Int, Direction)] = []
      var marker = direction
      while true {
        if visited.contains(where: { $0.0 == i && $0.1 == j && $0.2 == marker }) {
          return true
        }

        visited.append((i, j, marker))

        var nextI = i
        var nextJ = j
        switch marker {
        case .up: nextI -= 1
        case .down: nextI += 1
        case .left: nextJ -= 1
        case .right: nextJ += 1
        }

        if !((0..<map.count).contains(nextI) && (0..<map[nextI].count).contains(nextJ)) {
          return false
        }

        if map[nextI][nextJ] == "#" {
          marker =
            switch marker {
            case .up: .right
            case .right: .down
            case .down: .left
            case .left: .up
            }
        } else {
          i = nextI
          j = nextJ
        }
      }
    }

    let markedMap = generateMap()
    var maps = [[[String]]]()
    for i in 0..<markedMap.count {
      let row = markedMap[i]
      for j in 0..<row.count {
        if i == start.0 && j == start.1 {
          continue
        }
        if row[j] == "X" {
          var potentialMap = markedMap
          potentialMap[i][j] = "#"
          maps.append(potentialMap)
        }
      }
    }

    for testMap in maps {
      output += testIsLoop(map: testMap) ? 1 : 0
    }

    return output
  }
}
