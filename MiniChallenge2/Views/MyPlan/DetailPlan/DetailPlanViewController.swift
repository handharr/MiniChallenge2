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
    static let startButtonID = "startButtonID"
    
    // Data's
    private var pakets: [PaketModel] = []
    private var excercises: [ExerciseModel] = []
    var onGoing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Plan Name"
    
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Databases.retriveAllPaket { [weak self] res in
            
            switch res {
            case .success(let data):
                self?.pakets = data
            case .failure(let err):
                print("data paket error: \(err)")
            }
            
            self?.detailPlanCollectionView.reloadData()
        }
        
        Databases.retriveAllExercises { [weak self] res in
            
            switch res {
            case .success(let data):
                let usedData = data.filter {
                    return $0.paketid == "paket1"
                }
                self?.excercises = usedData
            case .failure(let err):
                print("data paket error: \(err)")
            }
            
            self?.detailPlanCollectionView.reloadData()
        }
    }
    
    private func setCollectionView() {
        detailPlanCollectionView.delegate = self
        detailPlanCollectionView.dataSource = self
        detailPlanCollectionView.collectionViewLayout = createCollectionViewLayout()
        
        detailPlanCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        detailPlanCollectionView.register(MCSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: DetailPlanViewController.excercisesHeaderID, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier)
        detailPlanCollectionView.register(DatePlanCollectionViewCell.nib(), forCellWithReuseIdentifier: DatePlanCollectionViewCell.identifier)
        detailPlanCollectionView.register(ExcerciseDetailPlanCollectionViewCell.nib(), forCellWithReuseIdentifier: ExcerciseDetailPlanCollectionViewCell.identifier)
        detailPlanCollectionView.register(SummaryDetailPlanCollectionViewCell.nib(), forCellWithReuseIdentifier: SummaryDetailPlanCollectionViewCell.identifier)
        detailPlanCollectionView.register(SectionButtonCollectionView.nib(), forSupplementaryViewOfKind: DetailPlanViewController.startButtonID, withReuseIdentifier: SectionButtonCollectionView.identifier)
    }
}

// MARK: - Collection View

extension DetailPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Set Item count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pakets.count
        case 1:
            return 1
        case 2:
            return excercises.count
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
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DatePlanCollectionViewCell.identifier, for: indexPath) as? DatePlanCollectionViewCell else {
                return defaultCell
            }
            
            cell.configureUI(idx: indexPath.row)
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExcerciseDetailPlanCollectionViewCell.identifier, for: indexPath) as? ExcerciseDetailPlanCollectionViewCell else {
                return defaultCell
            }
            
            cell.configureUI(model: excercises[indexPath.row], idx: indexPath.row)
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryDetailPlanCollectionViewCell.identifier, for: indexPath) as? SummaryDetailPlanCollectionViewCell else {
                return defaultCell
            }

            return cell
        }
        
        defaultCell.backgroundColor = MCColor.MCColorPrimary
        return defaultCell
    }
    
    // Set section's Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == DetailPlanViewController.excercisesHeaderID {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier, for: indexPath) as! MCSectionHeaderCollectionReusableView
            
            header.textLabel.text = "Excercises"
            
            return header
        } else {
            let startButton = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionButtonCollectionView.identifier, for: indexPath) as! SectionButtonCollectionView
            startButton.navigate = { [weak self] in
                
                if self?.onGoing == false {
                    let vc = SelectDayViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = ExcercisingViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return startButton
        }
    }
    
    // Layouting
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(140)
                    ),
                    subitem: item,
                    count: 5
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 20)
                
                // return
                return section
                
            } else if section == 1 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(85)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                
                // return
                return section
                
            } else if section == 2 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(92)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                
                // group
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(92)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: DetailPlanViewController.excercisesHeaderID,
                        alignment: .topLeading
                    ),
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(75)
                        ),
                        elementKind: DetailPlanViewController.startButtonID,
                        alignment: .bottomLeading
                    )
                ]
                
                // return
                return section
            }
            return nil
        }
    }
}
