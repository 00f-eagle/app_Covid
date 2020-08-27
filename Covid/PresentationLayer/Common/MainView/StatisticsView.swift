//
//  StatisticsView.swift
//  Covid
//
//  Created by Kirill Selivanov on 21.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsView: UIScrollView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let graphHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    
    private let statisticsStackView = StatisticsStackView()
    private let graphLog = GraphLog()
    private let collectionGraphLin = CollectionGraphLin(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var isMainStatisticsHidden: Bool? {
        didSet {
            if let isMainStatisticsHidden = isMainStatisticsHidden {
                statisticsStackView.isHidden = isMainStatisticsHidden
            }
        }
    }
    
    var isGraphHidden: Bool? {
        didSet {
            if let isGraphHidden = isGraphHidden {
                graphLog.isHidden = isGraphHidden
                collectionGraphLin.isHidden = isGraphHidden
            }
        }
    }
    
    var mainStatistics: StatisticsModel? {
        didSet {
            if let mainStatistics = mainStatistics {
                statisticsStackView.updateStatistics(statistics: mainStatistics)
            }
        }
    }
    
    var graphLogPoints: [GraphPointsLogModel]? {
        didSet {
            if let graphLogPoints = graphLogPoints {
                graphLog.graphPoint = graphLogPoints
            }
        }
    }
    
    var graphsLinPoints: [[GraphPointsLinModel]]? {
        didSet {
            if let graphsLinPoints = graphsLinPoints {
                collectionGraphLin.graphPoints = graphsLinPoints
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStatisticsScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func configureStatisticsScrollView() {
        addSubview(statisticsStackView)
        addSubview(graphLog)
        addSubview(collectionGraphLin)
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticsStackView.topAnchor.constraint(equalTo: topAnchor),
            statisticsStackView.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.topAnchor.constraint(equalTo: statisticsStackView.bottomAnchor, constant: Margin.top),
            graphLog.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.heightAnchor.constraint(equalToConstant: Locals.graphHeight),
            collectionGraphLin.topAnchor.constraint(equalTo: graphLog.bottomAnchor, constant: Margin.top),
            collectionGraphLin.widthAnchor.constraint(equalTo: widthAnchor),
            collectionGraphLin.heightAnchor.constraint(equalToConstant: Locals.graphHeight),
            collectionGraphLin.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
