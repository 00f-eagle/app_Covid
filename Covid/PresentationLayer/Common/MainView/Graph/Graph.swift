//
//  Graph.swift
//  Covid
//
//  Created by Kirill Selivanov on 01.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct Graph {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 8
        static let marginLeft: CGFloat = 5
        static let marginRight: CGFloat = 10
        static let marginTop: CGFloat = 10
        static let marginBottom: CGFloat = 20
        static let numberWidth: CGFloat = 49
        static let numberHeight: CGFloat = 10
        static let yData = [0, 0, 0, 0, 0]
        static let xData = ["22.01.20", "23.01.20", "24.01.20", "25.01.20", "26.01.20"]
    }
    
    // MARK: - Properties
    
    private let lineColor: UIColor = Colors.darkGray
    private let labelColor: UIColor = Colors.black
    
    private var graphHeight: CGFloat = 0
    private var graphWidth: CGFloat = 0
    private var yMax = 0
    
    var frame: CGRect = .zero {
        didSet {
            graphHeight = frame.height - Locals.marginBottom - Locals.marginTop
            graphWidth = frame.width - Locals.marginLeft - Locals.marginRight - Locals.numberWidth
        }
    }
    
    var yData: [Int] = Locals.yData {
        didSet {
            guard let maxPoint = yData.max() else { return }
            updateYMax(maxPoint: maxPoint)
        }
    }
    
    var xData: [String] = Locals.xData
    
    private let yLabels = { () -> [UILabel] in
        var labels: [UILabel] = []
        for _ in 0...5 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.textAlignment = .right
            labels.append(label)
        }
        return labels
    }()
    
    private let xLabels = { () -> [UILabel] in
        var labels: [UILabel] = []
        for _ in 0...4 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.textAlignment = .right
            labels.append(label)
        }
        return labels
    }()
    
    // MARK: - Draw
    
    func drawLines() -> UIBezierPath {
        let ySpacing = graphHeight / 5
        lineColor.setStroke()
        let line = UIBezierPath()
        for index in 0...5 {
            line.move(to: CGPoint(x: Locals.marginLeft + Locals.numberWidth, y: graphHeight + Locals.marginTop - CGFloat(index) * ySpacing))
            line.addLine(to: CGPoint(x: frame.width - Locals.marginRight, y: graphHeight + Locals.marginTop - CGFloat(index) * ySpacing))
        }
        return line
    }
    
    func drawYLabels() -> [UILabel] {
        let yLabelInterval = yMax / 5
        let ySpacing = graphHeight / 5
        for (index, label) in yLabels.enumerated() {
            label.text = "\(index * yLabelInterval)"
            label.frame = CGRect(x: 0, y: graphHeight + Locals.marginTop - Locals.numberHeight/2 - CGFloat(index) * ySpacing , width: Locals.numberWidth, height: Locals.numberHeight)
            label.textColor = labelColor
        }
        return yLabels
    }
    
    func drawXLabels() -> [UILabel] {
        let xLabelsInterval = getXLabelsInterval()
        for (index, interval) in xLabelsInterval.enumerated() {
            xLabels[index].text = xData[interval]
            xLabels[index].frame = CGRect(x: xPoint(x: interval) - Locals.numberWidth, y: graphHeight + Locals.marginTop + Locals.numberHeight/2, width: Locals.numberWidth, height: Locals.numberHeight)
            xLabels[index].textColor = labelColor
        }
        return xLabels
    }
    
    private func getXLabelsInterval() -> [Int] {
        let count = xData.count
        let x1 = 0
        let x2 = Int(ceilf(Float((count - 2)) / 4.0))
        let x3 = Int(ceilf(Float((count - 2)) / 2.0))
        let x4 = Int(ceilf(Float(3 * (count - 2)) / 4.0))
        let x5 = count - 1
        return [x1, x2, x3, x4, x5]
    }
    
    // MARK: - Calculate
    
    func xPoint(x: Int) -> CGFloat {
        let xSpacing = graphWidth / CGFloat(xData.count - 1)
        return CGFloat(x) * xSpacing + Locals.marginLeft + Locals.numberWidth
    }
    
    func yPoint(y: Int) -> CGFloat {
        let yPoint = CGFloat(y) / CGFloat(yMax) * graphHeight
        return graphHeight + Locals.marginTop - yPoint
    }
    
    private mutating func updateYMax(maxPoint: Int) {
        var everest = 100
        if maxPoint.numberOfDigits >= everest.numberOfDigits {
            everest = Int(ceil(pow(Double(10), Double(maxPoint.numberOfDigits)) / 100))
        }
        let firstDigit = maxPoint / everest + 1
        yMax = firstDigit * everest
    }
    
}
