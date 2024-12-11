//
//  Day10.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/10/24.
//

import Algorithms

struct Day10: AdventDay {
  var data: String

  var map: [[Int]] {
    return data.split(separator: "\n").map { $0.split(separator: "").map { Int($0)! } }
  }

  struct Location: Hashable {
    let i: Int
    let j: Int
  }

  func getNeighbors(coord: Location) -> [(Int, Location)] {
    let i = coord.i
    let j = coord.j

    var neighbors = [(Int, Location)]()
    if i - 1 >= 0 {
      neighbors.append((map[i - 1][j], Location(i: i - 1, j: j)))
    }
    if i + 1 < map.count {
      neighbors.append((map[i + 1][j], Location(i: i + 1, j: j)))
    }
    if j - 1 >= 0 {
      neighbors.append((map[i][j - 1], Location(i: i, j: j - 1)))
    }
    if j + 1 < map[0].count {
      neighbors.append((map[i][j + 1], Location(i: i, j: j + 1)))
    }
    return neighbors
  }

  func part1() -> Int {
    var output = 0
    var goodRoutes = [Location: [Location]]()

    for i in 0..<map.count {
      let row = map[i]
      for j in 0..<row.count {
        let curr = row[j]
        if curr != 0 {
          continue
        }
        let zero = Location(i: i, j: j)

        for one in getNeighbors(coord: zero).filter({ $0.0 == 1 }) {
          for two in getNeighbors(coord: (one.1)).filter({ $0.0 == 2 }) {
            for three in getNeighbors(coord: (two.1)).filter({ $0.0 == 3 }) {
              for four in getNeighbors(coord: (three.1)).filter({ $0.0 == 4 }) {
                for five in getNeighbors(coord: (four.1)).filter({ $0.0 == 5 }) {
                  for six in getNeighbors(coord: (five.1)).filter({ $0.0 == 6 }) {
                    for seven in getNeighbors(coord: (six.1)).filter({ $0.0 == 7 }) {
                      for eight in getNeighbors(coord: (seven.1)).filter({ $0.0 == 8 }) {
                        for nine in getNeighbors(coord: (eight.1)).filter({ $0.0 == 9 }) {
                          var markedMap = map.map { $0.map(String.init) }
                          for x in 0..<markedMap.count {
                            for y in 0..<markedMap[x].count {
                              if ![
                                zero, one.1, two.1, three.1, four.1, five.1, six.1, seven.1,
                                eight.1, nine.1,
                              ].contains(where: { co in
                                return co.i == x && co.j == y
                              }) {
                                markedMap[x][y] = "."
                              }
                            }
                          }
                          if !(goodRoutes[zero]?.contains(nine.1) ?? false) {
                            goodRoutes[zero, default: []].append(nine.1)
                            output += 1
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return output
  }

  func part2() -> Int {
    var output = 0

    for i in 0..<map.count {
      let row = map[i]
      for j in 0..<row.count {
        let curr = row[j]
        if curr != 0 {
          continue
        }
        let zero = Location(i: i, j: j)

        for one in getNeighbors(coord: zero).filter({ $0.0 == 1 }) {
          for two in getNeighbors(coord: (one.1)).filter({ $0.0 == 2 }) {
            for three in getNeighbors(coord: (two.1)).filter({ $0.0 == 3 }) {
              for four in getNeighbors(coord: (three.1)).filter({ $0.0 == 4 }) {
                for five in getNeighbors(coord: (four.1)).filter({ $0.0 == 5 }) {
                  for six in getNeighbors(coord: (five.1)).filter({ $0.0 == 6 }) {
                    for seven in getNeighbors(coord: (six.1)).filter({ $0.0 == 7 }) {
                      for eight in getNeighbors(coord: (seven.1)).filter({ $0.0 == 8 }) {
                        for nine in getNeighbors(coord: (eight.1)).filter({ $0.0 == 9 }) {
                          var markedMap = map.map { $0.map(String.init) }
                          for x in 0..<markedMap.count {
                            for y in 0..<markedMap[x].count {
                              if ![
                                zero, one.1, two.1, three.1, four.1, five.1, six.1, seven.1,
                                eight.1, nine.1,
                              ].contains(where: { co in
                                return co.i == x && co.j == y
                              }) {
                                markedMap[x][y] = "."
                              }
                            }
                          }
                          output += 1
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return output
  }
}
