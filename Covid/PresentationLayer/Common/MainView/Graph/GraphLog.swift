//
//  GraphLog.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class GraphLog: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 8
        static let yData = [0, 0, 0, 0, 0]
        static let xData = ["22.01.20", "23.01.20", "24.01.20", "25.01.20", "26.01.20"]
    }
    
    // MARK: - Properties
    
    private var graph = Graph()
    
    private let animationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
    
    private let shapeLayerConfirmed = CAShapeLayer()
    private let shapeLayerDeaths = CAShapeLayer()
    private let shapeLayerRecovered = CAShapeLayer()
    
    private var yConfirmedData: [Int] = Locals.yData
    private var yDeathsData: [Int] = Locals.yData
    private var yRecoveredData: [Int] = Locals.yData
    
    private var xData: [String] = Locals.xData
    
    var graphPoint: [GraphPointsLogModel]? {
        didSet {
            if let graphPoint = graphPoint {
                updateGraphPoints(graphPoints: graphPoint)
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
        configureShapeLayer(shapeLayer: shapeLayerConfirmed, color: Colors.orange.cgColor)
        configureShapeLayer(shapeLayer: shapeLayerRecovered, color: Colors.green.cgColor)
        configureShapeLayer(shapeLayer: shapeLayerDeaths, color: Colors.red.cgColor)
    }
    
    private func configureBasicAnimation() {
        animationStrokeEnd.fromValue = 0
        animationStrokeEnd.toValue = 1
        animationStrokeEnd.duration = 2
        animationStrokeEnd.fillMode = .forwards
        animationStrokeEnd.isRemovedOnCompletion = false
    }
    
    private func configureShapeLayer(shapeLayer: CAShapeLayer, color: CGColor) {
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = color
        shapeLayer.fillColor = .none
        layer.addSublayer(shapeLayer)
    }
    
    private func updateGraphPoints(graphPoints: [GraphPointsLogModel]) {
        guard graphPoints.count >= 5 else { return }
        xData = graphPoints.map { $0.date }
        yConfirmedData = graphPoints.map { $0.confirmed }
        yDeathsData = graphPoints.map { $0.deaths }
        yRecoveredData = graphPoints.map { $0.recovered }
        setNeedsDisplay()
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        graph.frame = rect
        graph.yData = yConfirmedData
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
        
        drawGraph(data: yConfirmedData, shapeLayer: shapeLayerConfirmed)
        drawGraph(data: yRecoveredData, shapeLayer: shapeLayerRecovered)
        drawGraph(data: yDeathsData, shapeLayer: shapeLayerDeaths)
    }
    
    private func drawGraph(data: [Int], shapeLayer: CAShapeLayer) {
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: graph.xPoint(x: 0), y: graph.yPoint(y: data[0])))
        for index in 1..<data.count {
            let nextPoint = CGPoint(x: graph.xPoint(x: index), y: graph.yPoint(y: data[index]))
            graphPath.addLine(to: nextPoint)
        }
        shapeLayer.path = graphPath.cgPath
        shapeLayer.add(animationStrokeEnd, forKey: "line")
    }
    
}
