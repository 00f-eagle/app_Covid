//
//  GraphLine.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class GraphLine: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 8
        static let yData = [0, 0, 0, 0, 0]
        static let xData = ["22.01.20", "23.01.20", "24.01.20", "25.01.20", "26.01.20"]
    }
    
    // MARK: - Properties
    
    private var graph = Graph()
    
    private let animationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
    private let shapeLayer = CAShapeLayer()
    
    private var xData: [String] = Locals.xData
    private var yData: [Int] = Locals.yData
    
    var graphColor: UIColor = .clear
    var graphPoints: [GraphPointsLineModel]? {
        didSet {
            if let graphPoints = graphPoints {
                updateGraphPoints(graphPoints: graphPoints)
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.gray
        layer.masksToBounds = true
        layer.cornerRadius = Locals.cornerRadius
        configureBasicAnimation()
        configureShapeLayer()
    }
    
    private func configureBasicAnimation() {
        animationStrokeEnd.fromValue = 0
        animationStrokeEnd.toValue = 1
        animationStrokeEnd.duration = 2
        animationStrokeEnd.fillMode = .forwards
        animationStrokeEnd.isRemovedOnCompletion = false
    }
    
    private func configureShapeLayer() {
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = .none
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        
        graph.frame = rect
        graph.yData = yData
        graph.xData = xData
        
        let lines = graph.drawLines()
        lines.stroke()
        
        let yLabels = graph.drawYLabels()
        yLabels.forEach { label in
            addSubview(label)
        }
        
        let xLabels = graph.drawXLabels()
        xLabels.forEach { label in
            addSubview(label)
        }
        
        drawGraph(data: yData)
    }
    
    // MARK: - Calculate
    
    private func drawGraph(data: [Int]) {
        let graphPath = UIBezierPath()
        
        for (index, y) in data.enumerated() {
            if y < 0 { continue }
            graphPath.move(to: CGPoint(x: graph.xPoint(x: index), y: graph.yPoint(y: 0)))
            let nextPoint = CGPoint(x: graph.xPoint(x: index), y: graph.yPoint(y: y))
            graphPath.addLine(to: nextPoint)
        }
//        graphColor.setStroke()
//        graphPath.stroke()
        shapeLayer.strokeColor = graphColor.cgColor
        shapeLayer.path = graphPath.cgPath
        shapeLayer.add(animationStrokeEnd, forKey: "line")
    }
    
    private func updateGraphPoints(graphPoints: [GraphPointsLineModel]) {
        guard graphPoints.count >= 5 else { return }
        xData = graphPoints.map { $0.date }
        yData = graphPoints.map { $0.status }
        setNeedsDisplay()
    }
}
