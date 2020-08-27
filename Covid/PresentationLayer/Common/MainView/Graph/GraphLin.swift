//
//  GraphLin.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class GraphLin: UICollectionViewCell {
    
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
    
    var graphColor: UIColor = Colors.orange
    var graphPoints: [GraphPointsLinModel]? {
        didSet {
            if let graphPoints = graphPoints {
                updateGraphPoints(graphPoints: graphPoints)
            }
        }
    }
    
    private let lineColor: UIColor = Colors.darkGray
    private let labelColor: UIColor = Colors.black
    
    private var xData: [String] = Locals.xData
    private var yData: [Int] = Locals.yData
    private var graphWidth: CGFloat = 0
    private var graphHeight: CGFloat = 0
    private var yMax = 0
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        // Create cornerRadius
        Colors.gray.setFill()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Locals.cornerRadius)
        path.addClip()
        path.fill()
        
        // Properties
        graphWidth = rect.width - Locals.marginLeft - Locals.marginRight - Locals.numberWidth
        graphHeight = rect.height - Locals.marginBottom - Locals.marginTop
        yMax = getYMax()
        
        // Draw YLabels
        let yLabelInterval = yMax / 5
        let ySpacing = graphHeight / 5
        lineColor.setStroke()
        for index in 0...5 {
            yLabels[index].text = "\(index * yLabelInterval)"
            yLabels[index].frame = CGRect(x: 0, y: graphHeight + Locals.marginTop - Locals.numberHeight/2 - CGFloat(index) * ySpacing , width: Locals.numberWidth, height: Locals.numberHeight)
            yLabels[index].textColor = labelColor
            addSubview(yLabels[index])
            let line = UIBezierPath()
            line.move(to: CGPoint(x: Locals.marginLeft + Locals.numberWidth, y: graphHeight + Locals.marginTop - CGFloat(index) * ySpacing))
            line.addLine(to: CGPoint(x: rect.width - Locals.marginRight, y: graphHeight + Locals.marginTop - CGFloat(index) * ySpacing))
            line.stroke()
        }
        
        // Draw XLabels
        let xLabelsInterval = getXLabelsInterval()
        for (index, interval) in xLabelsInterval.enumerated() {
            xLabels[index].text = xData[interval]
            xLabels[index].frame = CGRect(x: xPoint(x: interval) - Locals.numberWidth, y: graphHeight + Locals.marginTop + Locals.numberHeight/2, width: Locals.numberWidth, height: Locals.numberHeight)
            xLabels[index].textColor = labelColor
            addSubview(xLabels[index])
        }
        
        // Draw graph
        drawGraph(data: yData, colorGraph: graphColor)
    }
    
    // MARK: - Calculate
    
    private func xPoint(x: Int) -> CGFloat {
        let xSpacing = self.graphWidth / CGFloat(self.xData.count - 1)
        return CGFloat(x) * xSpacing + Locals.marginLeft + Locals.numberWidth
    }
    
    private func yPoint(y: Int) -> CGFloat {
        let yPoint = CGFloat(y) / CGFloat(yMax) * self.graphHeight
        return self.graphHeight + Locals.marginTop - yPoint
    }
    
    private func drawGraph(data: [Int], colorGraph: UIColor) {
        let graphPath = UIBezierPath()
        
        for (index, y) in data.enumerated() {
            if y < 0 { continue }
            graphPath.move(to: CGPoint(x: xPoint(x: index), y: yPoint(y: 0)))
            let nextPoint = CGPoint(x: xPoint(x: index), y: yPoint(y: y))
            graphPath.addLine(to: nextPoint)
        }
        colorGraph.setStroke()
        graphPath.stroke()
    }
    
    private func getXLabelsInterval() -> [Int] {
        let x1 = 0
        let x2 = Int(ceilf(Float((xData.count - 2)) / 4.0))
        let x3 = Int(ceilf(Float((xData.count - 2)) / 2.0))
        let x4 = Int(ceilf(Float(3 * (xData.count - 2)) / 4.0))
        let x5 = xData.count - 1
        return [x1, x2, x3, x4, x5]
    }
    
    private func getYMax() -> Int {
        var everest = 100
        guard let maxPoint = yData.max() else { return everest }
        if maxPoint.numberOfDigits >= everest.numberOfDigits {
            everest = Int(ceil(pow(Double(10), Double(maxPoint.numberOfDigits)) / 100))
        }
        let firstDigit = maxPoint / everest + 1
        let yMax = firstDigit * everest
        return yMax
    }
    
    private func updateGraphPoints(graphPoints: [GraphPointsLinModel]) {
        guard graphPoints.count >= 5 else { return }
        xData = graphPoints.map { $0.date }
        yData = graphPoints.map { $0.status }
        setNeedsDisplay()
    }
}
