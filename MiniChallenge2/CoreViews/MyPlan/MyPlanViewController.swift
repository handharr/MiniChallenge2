//
//  MyPlanViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class MyPlanViewController: UIViewController {
    
    @IBOutlet weak var myPlanCollectionView: UICollectionView!
    
    static let topHeaderId = "topHeaderID"
    var plansData: [[PlanModel]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Plan"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(goToCardioTest))
        
        setCollectionView()
    }
    
    @objc private func goToCardioTest() {
//        let vc = ExamCameraViewViewController()
        let vc = SelectDayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Databases.retriveAllPlan { [weak self] res in
            switch res {
            case .success(let datas):
                self?.plansData = datas
                
                DispatchQueue.main.async {
                    self?.myPlanCollectionView.reloadData()
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func setCollectionView() {
        myPlanCollectionView.delegate = self
        myPlanCollectionView.dataSource = self
        myPlanCollectionView.collectionViewLayout = createLayout()
        
        
        myPlanCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myPlanCollectionView.register(PlanCollectionViewCells.nib(), forCellWithReuseIdentifier: PlanCollectionViewCells.identifier)
        myPlanCollectionView.register(MCSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: MyPlanViewController.topHeaderId, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier)
    }
}

extension MyPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let datas = plansData else {
            return section == 0 ? 1 : 3
        }
        
        return datas[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        guard let datas = plansData else {
            return 4
        }
        
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        defaultCell.backgroundColor = MCColor.MCColorPrimary
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanCollectionViewCells.identifier, for: indexPath) as? PlanCollectionViewCells,
              let datas = plansData else {
            defaultCell.contentView.backgroundColor = .systemGray3
            return defaultCell
        }
        
        let model = datas[indexPath.section][indexPath.row]
        cell.configureUI(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let item = plansData?[indexPath.section][indexPath.row] else { return }
        
        let vc = DetailPlanViewController()
        vc.onGoing = item.onGoing
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MCSectionHeaderCollectionReusableView.identifier, for: indexPath) as! MCSectionHeaderCollectionReusableView
        
        if indexPath.section == 0 {
            header.textLabel.text = "On Going"
        } else if indexPath.section == 1 {
            header.textLabel.text = "Beginner"
        } else if indexPath.section == 2 {
            header.textLabel.text = "Intermediate"
        } else {
            header.textLabel.text = "Advance"
        }
        
        return header
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
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
                        heightDimension: .estimated(205)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 5, leading: 20, bottom: 5, trailing: 20)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: MyPlanViewController.topHeaderId,
                        alignment: .topLeading
                    )
                ]
                
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
                item.contentInsets = .init(top: 2, leading: 0, bottom: 2, trailing: 8 )
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .estimated(205)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 5, leading: 20, bottom: 5, trailing: 20)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: MyPlanViewController.topHeaderId,
                        alignment: .topLeading
                    )
                ]
                
                // return
                return section
            }
        }
    }
}
