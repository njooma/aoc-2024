//
//  Day08.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/9/24.
//

import Algorithms

struct Day08: AdventDay {
  var data: String

  var map: [[String]] {
    data.split(separator: "\n").map { $0.split(separator: "").map { String($0) } }
  }

  struct Location: Hashable {
    let i: Int
    let j: Int
  }

  func generateAntennaLocations() -> [String: [Location]] {
    var result = [String: [Location]]()
    for i in 0..<map.count {
      let row = map[i]
      for j in 0..<row.count {
        let char = row[j]
        if char != "." {
          result[char, default: [Location]()].append(Location(i: i, j: j))
        }
      }
    }
    return result
  }

  func checkBounds(location: Location) -> Bool {
    if location.i < 0 {
      return false
    }
    if location.j < 0 {
      return false
    }
    if location.i >= map.count {
      return false
    }
    if location.j >= map[0].count {
      return false
    }
    return true
  }

  func part1() -> Int {
    var antinodes = [Location]()

    for (_, locations) in generateAntennaLocations() {
      for lPair in locations.permutations(ofCount: 2) {
        let iDiff = lPair[1].i - lPair[0].i
        let jDiff = lPair[1].j - lPair[0].j
        let antinode1 = Location(i: lPair[0].i - iDiff, j: lPair[0].j - jDiff)
        let antinode2 = Location(i: lPair[1].i + iDiff, j: lPair[1].j + jDiff)
        if checkBounds(location: antinode1) {
          antinodes.append(antinode1)
        }
        if checkBounds(location: antinode2) {
          antinodes.append(antinode2)
        }
      }
    }
    return Set(antinodes).count
  }

  func part2() -> Int {
    var antinodes = [Location]()
    let antennae = generateAntennaLocations()
    for (_, locations) in antennae {
      for lPair in locations.permutations(ofCount: 2) {
        var iter = 0
        while true {
          iter += 1
          let iDiff = (lPair[1].i - lPair[0].i) * iter
          let jDiff = (lPair[1].j - lPair[0].j) * iter
          let antinode1 = Location(i: lPair[0].i - iDiff, j: lPair[0].j - jDiff)
          let antinode2 = Location(i: lPair[1].i + iDiff, j: lPair[1].j + jDiff)
          if checkBounds(location: antinode1) {
            antinodes.append(antinode1)
          }
          if checkBounds(location: antinode2) {
            antinodes.append(antinode2)
          }
          if !checkBounds(location: antinode1) && !checkBounds(location: antinode2) {
            break
          }
        }
      }
    }
    antinodes.append(contentsOf: antennae.filter { $1.count > 1 }.flatMap { $1 })
    return Set(antinodes).count
  }
}
