//
//  GraphView.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class GraphView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let marginLeft: CGFloat = 5
        static let marginRight: CGFloat = 10
        static let marginTop: CGFloat = 10
        static let marginBottom: CGFloat = 20
        static let numberWidth: CGFloat = 49
        static let numberHeight: CGFloat = 10
    }
    
    // MARK: - Properties
    
    private var xLabels: [UILabel] = []
    private var yLabels: [UILabel] = []
    private var graphPoints: [DayOneModel] = []
    private var gradient: CGGradient!
    
    var graphColor: UIColor = .black
    var clippingColor: UIColor = .clear
    var lineColor: UIColor = .darkGray
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xLabels = setupXLabels()
        yLabels = setupYLabels()
        setupGradient(startColor: .white, endColor: .gray)
        backgroundColor = Colors.black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        
        // Create cornerRadius
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRadius)
        path.addClip()
        
        // Create gradient
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        // Properties
        let graphWidth = rect.width - Constants.marginLeft - Constants.marginRight - Constants.numberWidth
        let graphHeight = rect.height - Constants.marginBottom - Constants.marginTop
        let yMax = getYMax()
        
        // Calculate the x point
        let xPoint = { (x: Int) -> CGFloat in
            let xSpacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(x) * xSpacing + Constants.marginLeft + Constants.numberWidth
        }
        
        // Calculate the y point
        let yPoint = { (y: Int) -> CGFloat in
            let yPoint = CGFloat(y) / CGFloat(yMax) * graphHeight
            return graphHeight + Constants.marginTop - yPoint
        }
        
        // Draw YLabels
        let yLabelInterval = yMax / 5
        let ySpacing = graphHeight / 5
        lineColor.setStroke()
        for index in 0...5 {
            yLabels[index].text = "\(index * yLabelInterval)"
            yLabels[index].frame = CGRect(x: 0, y: graphHeight + Constants.marginTop - Constants.numberHeight/2 - CGFloat(index) * ySpacing , width: Constants.numberWidth, height: Constants.numberHeight)
            addSubview(yLabels[index])
            let line = UIBezierPath()
            line.move(to: CGPoint(x: Constants.marginLeft + Constants.numberWidth, y: graphHeight + Constants.marginTop - CGFloat(index) * ySpacing))
            line.addLine(to: CGPoint(x: rect.width - Constants.marginRight, y: graphHeight + Constants.marginTop - CGFloat(index) * ySpacing))
            line.stroke()
        }
        
        // Draw XLabels
        let xLabelsInterval = getXLabelsInterval()
        for (index, xx) in xLabelsInterval.enumerated() {
            xLabels[index].text = graphPoints[xx].convertedDate
            xLabels[index].frame = CGRect(x: xPoint(xx) - Constants.numberWidth, y: graphHeight + Constants.marginTop + Constants.numberHeight/2, width: Constants.numberWidth, height: Constants.numberHeight)
            addSubview(xLabels[index])
        }
        
        // Draw graph
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: xPoint(0), y: yPoint(graphPoints[0].confirmed)))
        for index in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: xPoint(index), y: yPoint(graphPoints[index].confirmed))
            graphPath.addLine(to: nextPoint)
        }
        graphColor.setStroke()
        graphPath.stroke()
        
        // Draw clipping
        guard let clippingPath = graphPath.copy() as? UIBezierPath else { return }
        clippingPath.addLine(to: CGPoint(x: xPoint(graphPoints.count - 1), y: graphHeight + Constants.marginTop))
        clippingPath.addLine(to: CGPoint(x: xPoint(0), y: graphHeight + Constants.marginTop))
        clippingPath.close()
        clippingColor.setFill()
        clippingPath.fill()
    }
    
    // MARK: - Configurations
    
    private func setupYLabels() -> [UILabel] {
        var labels: [UILabel] = []
        for _ in 0...5 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.textColor = Colors.black
            label.textAlignment = .right
            labels.append(label)
        }
        return labels
    }
    
    private func setupXLabels() -> [UILabel] {
        var labels: [UILabel] = []
        for _ in 0...4 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.textColor = Colors.black
            label.textAlignment = .right
            labels.append(label)
        }
        return labels
    }
    
    private func getXLabelsInterval() -> [Int] {
        let x1 = 0
        let x2 = (graphPoints.count - 2) / 2
        let x3 = (graphPoints.count - 2) / 4
        let x4 = 3 * (graphPoints.count - 2) / 4
        let x5 = graphPoints.count - 1
        return [x1, x2, x3, x4, x5]
    }
    
    private func getYMax() -> Int {
        let maxPoint = graphPoints.max(by: { $0.confirmed < $1.confirmed })?.confirmed ?? 99
        let everest = Int(pow(Double(10), Double(maxPoint.numberOfDigits))) / 100
        let firstDigit = maxPoint / everest + 1
        let yMax = firstDigit * everest
        return yMax
    }
    
    // MARK: - User's config
    
    func setupGradient(startColor: UIColor, endColor: UIColor) {
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        self.gradient = gradient
    }
    
    func changeGraphPoints(statistics: [DayOneModel]) {
        graphPoints = statistics
        setNeedsDisplay()
    }
}
