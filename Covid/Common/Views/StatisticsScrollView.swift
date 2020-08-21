//
//  StatisticsScrollView.swift
//  Covid
//
//  Created by Kirill Selivanov on 21.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class StatisticsScrollView: UIScrollView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let graphHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    
    private let statisticsStackView = StatisticsStackView()
    private let graphLog = GraphView()
    
    var isGraphHidden: Bool! {
        willSet {
            graphLog.isHidden = newValue
        }
    }
    
    var statisticsModel: StatisticsModel! {
        willSet {
            statisticsStackView.changeStatisticsView(statistics: newValue)
        }
    }
    
    
    var graphLogPoints: [[String: [Int]]]! {
        willSet {
            graphLog.changeGraphPoints(data: newValue)
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
    
    private func configureStatisticsScrollView() {
        addSubview(statisticsStackView)
        addSubview(graphLog)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticsStackView.topAnchor.constraint(equalTo: topAnchor),
            statisticsStackView.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.topAnchor.constraint(equalTo: statisticsStackView.bottomAnchor, constant: Margin.top),
            graphLog.widthAnchor.constraint(equalTo: widthAnchor),
            graphLog.heightAnchor.constraint(equalToConstant: Locals.graphHeight),
            graphLog.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
