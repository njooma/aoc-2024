//
//  Day09.swift
//  AdventOfCode
//
//  Created by Naveed Jooma on 12/9/24.
//

import Algorithms

struct Day09: AdventDay {
  var data: String

  var diskMap: [Int] {
    return data.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "").map {
      Int($0)!
    }
  }

  func part1() -> Int {
    var fileSizes = Array(diskMap.striding(by: 2))
    var emptySizes = Array(diskMap.dropFirst().striding(by: 2))
    var output = [Int](repeating: -1, count: diskMap.reduce(0, +))

    var fileID = 0
    var fileHead = 0
    var fileTail = fileSizes.count - 1
    var start = 0
    var iter = 0
    while fileHead <= fileTail {
      let isFile = iter.isMultiple(of: 2)
      if isFile {
        let fileSize = fileSizes[fileHead]
        output[start..<start + fileSize] = ArraySlice(repeating: fileID, count: fileSize)
        fileID += 1
        start += fileSize
        fileHead += 1
      } else {
        while fileHead <= fileTail {
          let emptySize = emptySizes[0]
          let lastFileID = fileTail
          let lastFileSize = fileSizes[fileTail]
          if lastFileSize > emptySize {
            output[start..<start + emptySize] = ArraySlice(repeating: lastFileID, count: emptySize)
            fileSizes[fileTail] = lastFileSize - emptySize
            start += emptySize
            emptySizes.removeFirst()
            break
          } else if lastFileSize == emptySize {
            output[start..<start + emptySize] = ArraySlice(repeating: lastFileID, count: emptySize)
            fileTail -= 1
            emptySizes.removeFirst()
            start += emptySize
            break
          } else {
            output[start..<start + lastFileSize] = ArraySlice(
              repeating: lastFileID, count: lastFileSize)
            fileTail -= 1
            start += lastFileSize
            emptySizes[0] -= lastFileSize
          }
        }
      }
      iter += 1
    }

    return output.filter { $0 >= 0 }.enumerated().map { $0.offset * $0.element }.reduce(0, +)
  }

  func part2() -> Int {
    var output = [Int](repeating: -1, count: diskMap.reduce(0, +))

    var head = 0
    for (idx, size) in diskMap.enumerated() {
      let isFile = idx.isMultiple(of: 2)
      if isFile {
        output[head..<head + size] = ArraySlice(repeating: idx / 2, count: size)
      }
      head += size
    }

    let fileSizes = Array(diskMap.striding(by: 2))
    var emptySizes = Array(diskMap.dropFirst().striding(by: 2))
    for i in 0..<fileSizes.count {
      let fileTail = fileSizes.count - 1 - i
      let fileSize = fileSizes[fileTail]
      var emptyHead = 0
      while fileTail > emptyHead {
        let emptySize = emptySizes[emptyHead]
        if fileSize <= emptySize {
          if let toResetStart = output.firstIndex(of: fileTail) {
            output[toResetStart..<toResetStart + fileSize] = ArraySlice(
              repeating: -1, count: fileSize)
          }
          let start = output.indexOfContiguous(Array(repeating: -1, count: fileSize))!
          output[start..<start + fileSize] = ArraySlice(repeating: fileTail, count: fileSize)
          emptySizes[emptyHead] -= fileSize
          break
        } else {
          emptyHead += 1
        }
      }
    }

    var checksum = 0
    for (idx, file) in output.enumerated() {
      if file < 0 {
        continue
      }
      checksum += (idx * file)
    }
    return checksum
  }
}

extension Array where Element: Equatable {
  func indexOfContiguous(_ subArray: [Element]) -> Int? {

    // This is to prevent construction of a range from zero to negative
    if subArray.count > self.count {
      return nil
    }

    // The index of the match could not exceed data.count-part.count
    let r = (0...self.count - subArray.count)
    let x = r.firstIndex { ind in
      // Construct a sub-array from current index,
      // and compare its content to what we are looking for.
      [Element](self[ind..<ind + subArray.count]) == subArray
    }
    if let x {
      return r.distance(from: r.startIndex, to: x)
    }
    return nil
  }
}
