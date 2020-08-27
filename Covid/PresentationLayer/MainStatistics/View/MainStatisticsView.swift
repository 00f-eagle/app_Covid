//
//  MainStatisticsView.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.06.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class MainStatisticsView: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MainStatisticsViewOutput!
    
    private let progressView = UIProgressView()
    private let segmentedControl = UISegmentedControl()
    private let mainCountryView = StatisticsView()
    private let mainGlobalView = StatisticsView()
    
    private var error = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        progressView.isHidden = false
        presenter.getDataByCountry()
        presenter.getDataByGlobal()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        view.backgroundColor = Colors.white
        configureSegmentedControl()
        let refreshCountry = RefreshControlBuilder.createRefreshControl(action: #selector(refreshMainCountryView))
        let refreshGlobal = RefreshControlBuilder.createRefreshControl(action: #selector(refreshMainGlobalView))
        configureMainView(mainView: mainCountryView, refresh: refreshCountry)
        configureMainView(mainView: mainGlobalView, refresh: refreshGlobal)
        ProgressViewBuilder.configureProgressView(progressView: progressView, view: view)
        NotificationCenter.default.addObserver(self, selector: #selector(setupDefaultCountry), name: .didSetupDefaultCountry, object: nil)
    }
    
    private func configureSegmentedControl() {
        segmentedControl.insertSegment(withTitle: Texts.unknown, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Texts.world, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
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
    
    private func configureMainView(mainView: StatisticsView, refresh: UIRefreshControl) {
        mainView.refreshControl = refresh
        mainView.refreshControl = refresh
        mainView.isHidden = true
        mainView.isGraphHidden = true
        view.addSubview(mainView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                mainView.topAnchor.constraint(equalTo: segmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: Margin.top),
                mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                mainView.topAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: Margin.safeAreaTop + Margin.safeAreaTop),
                mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.heightOfTabBar + Margin.bottom)
            ])
        }
    }
    
    // MARK: - Active
    
    private func updateProgress(progress: Float) {
        progressView.progress += progress
        if progressView.progress == 1.0 {
            progressView.isHidden = true
            progressView.progress = 0
            didSelectSegment()
        }
    }
    
    @objc private func didSelectSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainGlobalView.isHidden = true
            mainCountryView.isHidden = false
        case 1:
            mainCountryView.isHidden = true
            mainGlobalView.isHidden = false
        default:
            break
        }
    }
    
    @objc private func refreshMainCountryView(_ sender: AnyObject) {
        error = false
        presenter.getDataByCountry()
        sender.endRefreshing()
    }
    
    @objc private func refreshMainGlobalView(_ sender: AnyObject) {
        error = false
        presenter.getDataByGlobal()
        sender.endRefreshing()
    }
    
    @objc private func setupDefaultCountry() {
        mainCountryView.isGraphHidden = true
        presenter.getDataByCountry()
    }
}


// MARK: - StatisticsViewInput
extension MainStatisticsView: MainStatisticsViewInput {
    
    func presentMainStatisticsByCountry(statistics: StatisticsModel) {
        mainCountryView.mainStatistics = statistics
        if segmentedControl.titleForSegment(at: 0) != statistics.name {
            segmentedControl.setTitle(statistics.name, forSegmentAt: 0)
        }
        updateProgress(progress: 0.5)
    }
    
    func presentGraphsByCountry(graphPointsLog: [GraphPointsLogModel], graphPointsLinConfirmed: [GraphPointsLinModel], graphPointsLinDeaths: [GraphPointsLinModel], graphPointsLinRecovered: [GraphPointsLinModel]) {
        mainCountryView.graphLogPoints = graphPointsLog
        mainCountryView.graphsLinPoints = [graphPointsLinConfirmed, graphPointsLinDeaths, graphPointsLinRecovered]
        mainCountryView.isGraphHidden = false
        updateProgress(progress: 0.5)
    }
    
    func presentMainStatisticsByGlobal(statistics: StatisticsModel) {
        mainGlobalView.mainStatistics = statistics
    }
    
    func failure() {
        if !error {
            error = true
            updateProgress(progress: 1.0)
            presenter.presentFailureAlert(title: Errors.error, message: Errors.data)
        }
    }
}
