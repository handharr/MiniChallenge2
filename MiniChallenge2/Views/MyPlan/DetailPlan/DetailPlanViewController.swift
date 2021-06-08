//
//  DetailPlanViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class DetailPlanViewController: UIViewController {
    
    @IBOutlet weak var detailPlanCollectionView: UICollectionView!
    
    let firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Plan Name"
        
        detailPlanCollectionView.delegate = self
        detailPlanCollectionView.dataSource = self
        detailPlanCollectionView.collectionViewLayout = createCollectionViewLayout()
        
        detailPlanCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1/5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(95)
                    ),
                    subitem: item,
                    count: 5
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12.6, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
                // return
                return section
                
            } else {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                // group
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    ),
                    subitem: item,
                    count: 5
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12.6, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                
                // return
                return section
            }
        }

    }
}

// MARK: - Collection View

extension DetailPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 20 : 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = MCColor.MCColorPrimary
        return cell
    } 
}
