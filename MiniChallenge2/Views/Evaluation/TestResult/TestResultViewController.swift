//
//  TestResultViewController.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 09/06/21.
//

import UIKit

class TestResultViewController: UIViewController {
    
    var tables : [UITableView] = []
    var dataCount = 4
    
    lazy var scrollView : UIScrollView = {
        self.setUpTable()
        print("Masuk")
        print(tables.count)
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        let scrollViewHeight = UIScreen.main.bounds.height
        let scrollViewWidth = tabBarController?.view.frame.width ?? 0
        
        let scrollViewHeightFinal = scrollViewHeight - (tabBarController?.tabBar.frame.height)! - (navigationController?.navigationBar.frame.maxY)!
        
        scrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(dataCount), height: scrollViewHeightFinal)
        
        for i in 0..<dataCount{
            scrollView.addSubview(tables[i])
            tables[i].frame = CGRect(x: scrollViewWidth * CGFloat(i), y: 0, width: scrollViewWidth, height: scrollViewHeightFinal)
            print(tables[i].frame)
        }
        
        scrollView.delegate = self
        
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = dataCount > 1 ? dataCount : 0
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .sweetBrown
        return pageControl
    }()
    
    @objc
    func pageControlTapHandler(sender: UIPageControl){
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cardio Test Result"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(scrollView)
        scrollView.edgeTos(view: view, navigation: (navigationController?.navigationBar)!, tabBar: (tabBarController?.tabBar)!)
        
        view.addSubview(pageControl)
        pageControl.pinTo(view: view, tabBar: (tabBarController?.tabBar)!)
    }
    
    func setUpTable(){
        for _ in 0..<dataCount {
            let table = UITableView(frame: CGRect(), style: .insetGrouped)
            table.backgroundColor = .systemBackground
            table.register(CardioTableViewCell.getNib(), forCellReuseIdentifier: CardioTableViewCell.getIdentifier())
            table.register(GradingCriteriaTableViewCell.getNib(), forCellReuseIdentifier: GradingCriteriaTableViewCell.getIdentifier())
            table.delegate = self
            table.dataSource = self
            table.separatorStyle = .none
            table.allowsSelection = false
            
            tables.append(table)
        }
    }
}

// MARK: - UIScrollView Delegate
extension TestResultViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

// MARK: - UITableView Delegate
extension TestResultViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MCTableViewSectionHeader(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 30))

        if section == 0 {
            header.textLabel.text = "Result"
            header.textLabel.frame.size.height = 40
            return header
        } else {
            header.textLabel.text = "Grading Criteria"
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        214
    }
}

// MARK: - UITableView DataSource
extension TestResultViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            for i in 0..<dataCount {
                if tableView == tables[i]{
                    return i+1
                }
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let resultCell = tableView.dequeueReusableCell(withIdentifier: CardioTableViewCell.getIdentifier(), for: indexPath) as! CardioTableViewCell
            return resultCell
        }
        
        else {
            let gradingCell = tableView.dequeueReusableCell(withIdentifier: GradingCriteriaTableViewCell.getIdentifier(), for: indexPath) as! GradingCriteriaTableViewCell
            gradingCell.setData()
            return gradingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}
