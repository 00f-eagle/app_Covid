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
        static let circleDiameter: CGFloat = 2
        static let numberWidth: CGFloat = 50
        static let numberHeight: CGFloat = 10
    }
    
    private enum length {
        
    }
    
    private let mainColor = Colors.orange
    private let startColor = Colors.white
    private let endColor = Colors.orange
    private let graphColor = Colors.white
    private let clippingColor = Colors.whiteClear
    
    // MARK: - Properties
    
    private var graphPoints: [DayOneModel] = []
    
    private let averageWaterDrunk = UILabel()
    private let maxLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        
        //        guard let context = UIGraphicsGetCurrentContext() else { return }
        //        context.setStrokeColor(Colors.orange.cgColor)
        //        context.strokePath()
        //        let colors = [startColor.cgColor, endColor.cgColor]
        //        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //        let colorLocations: [CGFloat] = [0.0, 1.0]
        //
        //        guard let gradient = CGGradient(
        //            colorsSpace: colorSpace,
        //            colors: colors as CFArray,
        //            locations: colorLocations
        //            ) else {
        //                return
        //        }
        //
        //        let startPoint = CGPoint.zero
        //        let endPoint = CGPoint(x: 0, y: bounds.height)
        //        context.drawLinearGradient(
        //            gradient,
        //            start: startPoint,
        //            end: endPoint,
        //            options: []
        //        )
        
        
        // Create cornerRadius
        mainColor.setFill()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRadius)
        path.fill()
        
        // Calculate the x point
        
        let graphWidth = rect.width - Constants.marginLeft - Constants.marginRight - Constants.numberWidth
        let xSpacing = graphWidth / CGFloat(graphPoints.count - 1)
        let xPoint = { (x: Int) -> CGFloat in
            return CGFloat(x) * xSpacing + Constants.marginLeft + Constants.numberWidth
        }
        
        // Calculate the y point
        
        let graphHeight = rect.height - Constants.marginBottom - Constants.marginTop
        
        var yMax = 100
        
        for point in graphPoints {
            if point.confirmed > yMax {
                yMax = point.confirmed
            }
        }
        yMax = yMax.round
        let yPoint = { (y: Int) -> CGFloat in
            let yPoint = CGFloat(y) / CGFloat(yMax) * graphHeight
            return graphHeight + Constants.marginTop - yPoint
        }
        
        let yLabelInterval = yMax / 5
        let ySpacing = graphHeight / 5
        
        for i in 0...5 {
            
            let label = axisLabel(text: "\(i * yLabelInterval)")
            label.frame = CGRect(x: 0, y: graphHeight + Constants.marginTop - Constants.numberHeight/2 - CGFloat(i) * ySpacing , width: Constants.numberWidth, height: Constants.numberHeight)
            addSubview(label)
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: Constants.marginLeft + Constants.numberWidth, y: graphHeight + Constants.marginTop - CGFloat(i) * ySpacing))
            line.addLine(to: CGPoint(x: rect.width - Constants.marginRight, y: graphHeight + Constants.marginTop - CGFloat(i) * ySpacing))
            Colors.black.setStroke()
            line.stroke()
            
        }
        
        // Draw graph
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: xPoint(0), y: yPoint(0)))
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
        
        // Draw the circles on top of the graph stroke
        
        let x1 = 0
        let x2 = (graphPoints.count - 2) / 2
        let x3 = (graphPoints.count - 2) / 4
        let x4 = 3 * (graphPoints.count - 2) / 4
        let x5 = graphPoints.count - 1
        
        graphColor.setFill()
        for (index, points) in graphPoints.enumerated() {
            
            switch index {
            case x1, x2, x3, x4, x5:
                let label = axisLabel(text: graphPoints[index].convertedDate)
                label.frame = CGRect(x: xPoint(index) - Constants.numberWidth, y: graphHeight + Constants.marginTop + Constants.numberHeight/2, width: Constants.numberWidth, height: Constants.numberHeight)
                addSubview(label)
            default:
                break
            }
            
            var point = CGPoint(x: xPoint(index), y: yPoint(points.confirmed))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            circle.fill()
            
            //            if index == 0, index == graphPoints.count - 1 {
            //                let xLabel = axisLabel(text: points.convertedDate)
            //                xLabel.frame = CGRect(x: Constants.marginLeft + Constants.numberWidth, y: graphHeight + 20, width: 36, height: 20)
            //            }
        }
    }
    
    // Returns an axis label
    private func axisLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 10)
        label.textColor = Colors.black
        label.textAlignment = .right
        return label
    }
    
//    private func xLabel(index: Int) {
//        let label = axisLabel(text: graphPoints[index].convertedDate)
//        label.frame = CGRect(x: Constants.marginLeft + Constants.numberWidth + CGFloat(index) - Constants.numberHeight/2, y: graphHeight + Constants.marginTop, width: Constants.numberWidth, height: Constants.numberHeight)
//        addSubview(label)
//    }
    
    func changeGraphPoints(statistics: [DayOneModel]) {
        graphPoints = statistics
        setNeedsDisplay()
    }
}
