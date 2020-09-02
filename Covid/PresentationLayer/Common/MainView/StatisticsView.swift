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
    private let collectionGraphLine = CollectionGraphLine(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
                collectionGraphLine.isHidden = isGraphHidden
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
    
    var graphsLinPoints: [[GraphPointsLineModel]]? {
        didSet {
            if let graphsLinPoints = graphsLinPoints {
                collectionGraphLine.graphPoints = graphsLinPoints
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStatisticsScrollView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    
    // MARK: - Configurations
    
    private func configureStatisticsScrollView() {
        addSubview(statisticsStackView)
        addSubview(graphLog)
        addSubview(collectionGraphLine)
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticsStackView.topAnchor.constraint(equalTo: topAnchor),
            statisticsStackView.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.topAnchor.constraint(equalTo: statisticsStackView.bottomAnchor, constant: Margin.top),
            graphLog.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.heightAnchor.constraint(equalToConstant: Locals.graphHeight),
            collectionGraphLine.topAnchor.constraint(equalTo: graphLog.bottomAnchor, constant: Margin.top),
            collectionGraphLine.widthAnchor.constraint(equalTo: widthAnchor),
            collectionGraphLine.heightAnchor.constraint(equalToConstant: Locals.graphHeight),
            collectionGraphLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
