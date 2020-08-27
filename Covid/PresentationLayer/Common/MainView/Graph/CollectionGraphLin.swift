//
//  CollectionGraphLin.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CollectionGraphLin: UICollectionView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let identifierCell = "GraphLin"
    }
    
    // MARK: - Properties
    
    var graphPoints: [[GraphPointsLinModel]] = [[], [], []] {
        didSet {
            reloadData()
        }
    }
    
    private let colors = [Colors.orange, Colors.red, Colors.green]
    
    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionGraphLin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func configureCollectionGraphLin() {
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.white
        showsHorizontalScrollIndicator = false
        register(GraphLin.self, forCellWithReuseIdentifier: Locals.identifierCell)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}


// MARK: - UICollectionViewDataSource
extension CollectionGraphLin: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        graphPoints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Locals.identifierCell, for: indexPath) as? GraphLin {
            cell.graphPoints = graphPoints[indexPath.row]
            cell.graphColor = colors[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionGraphLin: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: bounds.height)
    }
}
