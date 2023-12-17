//
//  main.swift
//  Xcode Benchmark
//
//  Created by Luke Buckner on 12/7/23.
//

import Foundation
import Accelerate
import CommonCrypto

func runBenchmark() {
    let arraySize = 2_000_000
    var numbers = (1...arraySize).map { _ in Int.random(in: 1...100000) }

    print("Beginning benchmark...")

    // Measure the time taken to sort the array
    let sortStartDate = Date()
    numbers.sort()
    let sortEndDate = Date()

    // Additional CPU-intensive calculations
    let calculationStartDate = Date()
    performCPUCalculations()
    let calculationEndDate = Date()

    // String manipulation task
    let stringManipulationStartDate = Date()
    performStringManipulation()
    let stringManipulationEndDate = Date()

    // Array manipulation task
    let arrayManipulationStartDate = Date()
    performArrayManipulation()
    let arrayManipulationEndDate = Date()

    // Complex mathematical calculations
    let complexCalculationStartDate = Date()
    performComplexCalculations()
    let complexCalculationEndDate = Date()

    // Dictionary manipulation task
    let dictionaryManipulationStartDate = Date()
    performDictionaryManipulation()
    let dictionaryManipulationEndDate = Date()

    // Bitwise operations task
    let bitwiseOperationsStartDate = Date()
    performBitwiseOperations()
    let bitwiseOperationsEndDate = Date()

    // Matrix operations task
    let matrixOperationsStartDate = Date()
    performMatrixOperations()
    let matrixOperationsEndDate = Date()

    // Advanced algorithm simulation
    let advancedAlgorithmStartDate = Date()
    performAdvancedAlgorithmSimulation()
    let advancedAlgorithmEndDate = Date()

    // Cryptographic hash function
    let cryptographicHashStartDate = Date()
    performCryptographicHash()
    let cryptographicHashEndDate = Date()

    // Parallel processing using GCD
    let parallelProcessingStartDate = Date()
    performParallelProcessing()
    let parallelProcessingEndDate = Date()

    // Calculate elapsed time for various tasks
    let sortElapsed = sortEndDate.timeIntervalSince(sortStartDate)
    let calculationElapsed = calculationEndDate.timeIntervalSince(calculationStartDate)
    let stringManipulationElapsed = stringManipulationEndDate.timeIntervalSince(stringManipulationStartDate)
    let arrayManipulationElapsed = arrayManipulationEndDate.timeIntervalSince(arrayManipulationStartDate)
    let complexCalculationElapsed = complexCalculationEndDate.timeIntervalSince(complexCalculationStartDate)
    let dictionaryManipulationElapsed = dictionaryManipulationEndDate.timeIntervalSince(dictionaryManipulationStartDate)
    let bitwiseOperationsElapsed = bitwiseOperationsEndDate.timeIntervalSince(bitwiseOperationsStartDate)
    let matrixOperationsElapsed = matrixOperationsEndDate.timeIntervalSince(matrixOperationsStartDate)
    let advancedAlgorithmElapsed = advancedAlgorithmEndDate.timeIntervalSince(advancedAlgorithmStartDate)
    let cryptographicHashElapsed = cryptographicHashEndDate.timeIntervalSince(cryptographicHashStartDate)
    let parallelProcessingElapsed = parallelProcessingEndDate.timeIntervalSince(parallelProcessingStartDate)

    print("Sorting completed in \(sortElapsed) seconds")
    print("Calculations completed in \(calculationElapsed) seconds")
    print("String manipulation completed in \(stringManipulationElapsed) seconds")
    print("Array manipulation completed in \(arrayManipulationElapsed) seconds")
    print("Complex calculations completed in \(complexCalculationElapsed) seconds")
    print("Dictionary manipulation completed in \(dictionaryManipulationElapsed) seconds")
    print("Bitwise operations completed in \(bitwiseOperationsElapsed) seconds")
    print("Matrix operations completed in \(matrixOperationsElapsed) seconds")
    print("Advanced algorithm simulation completed in \(advancedAlgorithmElapsed) seconds")
    print("Cryptographic hash function completed in \(cryptographicHashElapsed) seconds")
    print("Parallel processing completed in \(parallelProcessingElapsed) seconds")
}

func performCPUCalculations() {
    var result = 0
    for _ in 1...2_000_000 {
        result += Int.random(in: 1...100)
        result -= Int.random(in: 1...100)
    }
}

func performStringManipulation() {
    var result = ""
    for _ in 1...200_000 {
        result += "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    }
}

func performArrayManipulation() {
    var array = [Int]()
    for _ in 1...500 {
        array.append(contentsOf: (1...2_000).map { _ in Int.random(in: 1...100) })
        array.removeAll()
    }
}

func performComplexCalculations() {
    for _ in 1...100 {
        let _ = (1...10_000).map { sqrt(Double($0)) + sin(Double($0)) }
    }
}

func performDictionaryManipulation() {
    var dictionary = [Int: String]()
    for i in 1...50_000 {
        dictionary[i] = "Value\(i)"
    }
    dictionary.removeAll()
}

func performBitwiseOperations() {
    var result = 0
    for i in 1...1_000_000 {
        result ^= i
    }
}

func performMatrixOperations() {
    let matrixSize = 500
    var matrixA = [Double](repeating: 0.0, count: matrixSize * matrixSize)
    var matrixB = [Double](repeating: 0.0, count: matrixSize * matrixSize)
    var matrixResult = [Double](repeating: 0.0, count: matrixSize * matrixSize)

    for i in 0..<matrixSize {
        for j in 0..<matrixSize {
            matrixA[i * matrixSize + j] = Double(i + j)
            matrixB[i * matrixSize + j] = Double(i - j)
        }
    }

    vDSP_mmulD(matrixA, 1, matrixB, 1, &matrixResult, 1, vDSP_Length(matrixSize), vDSP_Length(matrixSize), vDSP_Length(matrixSize))
}

func performAdvancedAlgorithmSimulation() {
    let iterations = 10_000
    var result = 0

    for _ in 1...iterations {
        for i in 1...1000 {
            result += Int(pow(Double(i), 2.0)) * Int(arc4random_uniform(100))
        }
    }
}

func performCryptographicHash() {
    let inputString = "This is a test string for cryptographic hashing."
    let inputData = Data(inputString.utf8)

    var hashedData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
     hashedData.withUnsafeMutableBytes { outputBuffer in
        inputData.withUnsafeBytes { inputBuffer in
            _ = CC_SHA256(inputBuffer.baseAddress, CC_LONG(inputData.count), outputBuffer.bindMemory(to: UInt8.self).baseAddress)
        }
    }

    print("Hash: \(hashedData.map { String(format: "%02hhx", $0) }.joined())")
}

func performParallelProcessing() {
    let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    let group = DispatchGroup()

    for _ in 1...10 {
        concurrentQueue.async(group: group) {
            performCPUCalculations()
        }
    }

    // Wait for all tasks to complete
    group.wait()
}

runBenchmark()
