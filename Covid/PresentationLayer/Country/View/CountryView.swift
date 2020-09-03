//
//  CountryView.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryView: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CountryViewOutput!
    
    private let progressView = UIProgressView()
    private let buttonsStack = UIStackView()
    private let mainView = StatisticsView()
    
    private var error = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getDataByCountry()
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        view.backgroundColor = Colors.white
        configureButtonsStack()
        configureMainView()
        ProgressViewBuilder.configureProgressView(progressView: progressView, view: view)
    }
    
    private func configureButtonsStack() {
        let backButton = createButton(text: Texts.back, action: #selector(backAction))
        let defaultButton = createButton(text: Texts.setupDefault, action: #selector(defaultCountryAction))
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(backButton)
        buttonsStack.addArrangedSubview(defaultButton)
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 10
        view.addSubview(buttonsStack)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.safeAreaTop),
                buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        }
    }
    
    private func createButton(text: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle(text, for: .normal)
        button.setTitleColor(Colors.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = Colors.gray
        button.layer.cornerRadius = Margin.cornerRadius
        return button
    }
    
    private func configureMainView() {
        let refresh = RefreshControlBuilder.createRefreshControl(action: #selector(refreshData))
        mainView.refreshControl = refresh
        mainView.isHidden = true
        mainView.isGraphHidden = true
        view.addSubview(mainView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                mainView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: Margin.top),
                mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                mainView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: Margin.top),
                mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.bottom)
            ])
        }
    }
    
    // MARK: - Action
    
    private func updateProgress(progress: Float) {
        progressView.progress += progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.layoutIfNeeded()
        }
        
        if progressView.progress == 1.0 {
            progressView.isHidden = true
            progressView.progress = 0
            mainView.isHidden = false
        }
    }
    
    @objc private func backAction() {
        presenter.dismissView()
    }
    
    @objc private func defaultCountryAction() {
        presenter.setupDefaultCountry()
    }
    
    @objc private func refreshData(_ sender: AnyObject) {
        error = false
        presenter.getDataByCountry()
        sender.endRefreshing()
    }
}


// MARK: - CountryViewInput
extension CountryView: CountryViewInput {
    func presetMainStatistics(statistics: StatisticsModel) {
        mainView.mainStatistics = statistics
        updateProgress(progress: 0.5)
    }
    
    func presentGraphs(graphPointsLog: [GraphPointsLogModel], graphPointsLinConfirmed: [GraphPointsLineModel], graphPointsLinDeaths: [GraphPointsLineModel], graphPointsLinRecovered: [GraphPointsLineModel]) {
        mainView.graphLogPoints = graphPointsLog
        mainView.graphsLinPoints = [graphPointsLinConfirmed, graphPointsLinDeaths, graphPointsLinRecovered]
        mainView.isGraphHidden = false
        updateProgress(progress: 0.5)
    }
    
    func failure() {
        if !error {
            error = true
            updateProgress(progress: 1.0)
            presenter.presentFailureAlert(title: Errors.error, message: Errors.data)
        }
    }
}
