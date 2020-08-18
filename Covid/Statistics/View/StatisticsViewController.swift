//
//  StatisticsViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.06.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let heightGraph: CGFloat = 200
    }
    
    // MARK: - Properties
    
    var presenter: StatisticsViewOutput!
    
    private let indicator = UIActivityIndicatorView()
    private let segmentedControl = UISegmentedControl()
    private let refreshControl = UIRefreshControl()
    private let scrollView = UIScrollView()
    
    private let statisticsStackView = StatisticsStackView()
    private let graph = GraphView()
    
    private var country = Texts.unknown
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataBySelectedSegment()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        view.backgroundColor = Colors.white
        configureActivityIndicator()
        configureSegmentedControl()
        configureScrollView()
        configureStatisticsStackView()
        configureGraph()
    }
    
    private func configureActivityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureSegmentedControl() {
        segmentedControl.insertSegment(withTitle: country, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Texts.world, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(getDataBySelectedSegment), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.top)
            ])
        } else {
            NSLayoutConstraint.activate([
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.safeAreaTop + Margin.safeAreaTop)
            ])
        }
    }
    
    private func configureScrollView() {
        refreshControl.addTarget(self, action: #selector(getDataBySelectedSegment), for: .valueChanged)
        refreshControl.tintColor = Colors.black
        scrollView.refreshControl = refreshControl
        scrollView.addSubview(statisticsStackView)
        scrollView.addSubview(graph)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        view.addSubview(scrollView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                scrollView.topAnchor.constraint(equalTo: segmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: Margin.top),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                scrollView.topAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: Margin.safeAreaTop + Margin.safeAreaTop),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.heightOfTabBar + Margin.bottom)
            ])
        }
    }
    
    private func configureStatisticsStackView() {
        NSLayoutConstraint.activate([
        statisticsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        statisticsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
        statisticsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
        ])
    }
    
    private func configureGraph() {
        NSLayoutConstraint.activate([
            graph.topAnchor.constraint(equalTo: statisticsStackView.bottomAnchor, constant: Margin.top),
            graph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
            graph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
            graph.heightAnchor.constraint(equalToConstant: Locals.heightGraph),
            graph.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc private func getDataBySelectedSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            indicator.startAnimating()
            presenter.getDataByCountry()
        case 1:
            indicator.startAnimating()
            presenter.getDataByGlobal()
        default:
            break
        }
    }
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    func success(statistics: StatisticsModel, dayOne: [[String: [Int]]]?) {
        statisticsStackView.changeStatisticsView(statistics: statistics)
        
        if let dayOne = dayOne {
            graph.changeGraphPoints(data: dayOne)
            graph.isHidden = false
        } else {
            graph.isHidden = true
        }
        
        if segmentedControl.selectedSegmentIndex == 0, country != statistics.name  {
            country = statistics.name
            segmentedControl.setTitle(country, forSegmentAt: 0)
        }
        
        indicator.stopAnimating()
        refreshControl.endRefreshing()
        scrollView.isHidden = false
    }
    
    func failure() {
        indicator.stopAnimating()
        refreshControl.endRefreshing()
        presenter.presentFailureAlert(title: Errors.error, message: Errors.data)
    }
}
