//
//  DetailPlanViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class DetailPlanViewController: UIViewController {
    
    @IBOutlet weak var detailPlanCollectionView: UICollectionView!
    
    static let excercisesHeaderID = "excercisesHeaderID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Plan Name"
    
        setCollectionView()
    }
    
    private func setCollectionView() {
        detailPlanCollectionView.delegate = self
        detailPlanCollectionView.dataSource = self
        detailPlanCollectionView.collectionViewLayout = createCollectionViewLayout()
        
        detailPlanCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        detailPlanCollectionView.register(MCSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: DetailPlanViewController.excercisesHeaderID, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier)
    }
}

// MARK: - Collection View

extension DetailPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Set Item count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 20
        case 1:
            return 1
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    // Set Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    // Set item's cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = MCColor.MCColorPrimary
        return cell
    }
    
    // Set section's Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier, for: indexPath) as! MCSectionHeaderCollectionReusableView
        
        header.textLabel.text = "Excercises"
        
        return header
    }
    
    // Layouting
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(127)
                    ),
                    subitem: item,
                    count: 5
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
                // return
                return section
                
            } else if section == 1 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(100)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                
                // return
                return section
            } else if section == 2 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                
                // group
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    ),
                    subitem: item,
                    count: 5
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: DetailPlanViewController.excercisesHeaderID,
                        alignment: .topLeading
                    )
                ]
                
                // return
                return section
            }
            return nil
        }
    }
}
