//
//  ExcercisingViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit
import AVKit
import AVFoundation



class ExcercisingViewController: UIViewController, ActionSectionDelegate {
    func nextExercise() {
        position += 1
        nextExer()
    }
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var actionContainerView: ActionSectionView!
    
    
    var exerciseList = [Exercise]()
    var position = 0
    var timer = Timer()
    var exerciseTimer = Timer()
    var count = 0
    var isActive = false
    var totalSet = 3
    var currentSet = 1
    var timeString = ""
    
//    let subView:VideoSectionView = {
//        let subView = VideoSectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 545))
//        return subView
//    }()
    lazy var subView2:ActionSectionView = {
        let subView = ActionSectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 320))
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.delegate = self
        return subView
    }()
    
    var layers = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureExercise()
        self.view.addSubview(subView2)
        subView2.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent
        self.navigationItem.hidesBackButton = true
        blurView.applyBlurEffect(blurView)
        constrainSubView2()
        subView2.totalExercise = exerciseList.count
        
//        actionContainer.setUpNewView(
//        nextExer()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(quitAlertVC))
        timeSpend()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nextExer()
        
    }
    
    func configureExercise(){
        exerciseList.append(Exercise(exerciseTitle: "Crunches", repetition: 30, videoName: "crunches", exerciseType:"timeBase"))
        exerciseList.append(Exercise(exerciseTitle: "break", repetition: 10, videoName: "break_1", exerciseType:"timeBase"))
        exerciseList.append(Exercise(exerciseTitle: "PushUp", repetition: 8, videoName: "Push up", exerciseType:"countBase"))
        exerciseList.append(Exercise(exerciseTitle: "break", repetition: 10, videoName: "break_1", exerciseType:"timeBase"))
        exerciseList.append(Exercise(exerciseTitle: "SitUp", repetition: 8, videoName: "sit up", exerciseType:"countBase"))
        exerciseList.append(Exercise(exerciseTitle: "break", repetition: 10, videoName: "break_1", exerciseType:"timeBase"))
    }
    func nextExer(){
        if position < exerciseList.count{
            subView2.setUpView(data: exerciseList[position], exerciseNumber: position)
//            subView2.nextExerciseLabel.text = "\(exerciseList[position+1].exerciseTitle)"
            playVideo()
        }
        else if position == exerciseList.count && currentSet < totalSet{
            position = 0
            currentSet += 1
            subView2.setCounterLabel.text = "\(currentSet)/\(totalSet)"
            subView2.setUpView(data: exerciseList[position], exerciseNumber: position)
//            subView2.nextExerciseLabel.text = "\(exerciseList[position+1].exerciseTitle)"
        }
        else if position == exerciseList.count && currentSet == totalSet{
            closeButton()
            timer.invalidate()
        }
        
    }
    var timerExer = 0
    
    private func constrainSubView2(){
        var constraints = [NSLayoutConstraint]()
        
//        add
        constraints.append(subView2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0 ))
        constraints.append(subView2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0 ))
        constraints.append(subView2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0 ))
        constraints.append(subView2.topAnchor.constraint(equalTo: videoContainer.topAnchor, constant: 410 ))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func closeButton(){
        let vc = CongratulationViewController()
        vc.timeString = timeString
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    var layers = AVPlayerLayer()
    func playVideo(){
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: exerciseList[position].videoName, ofType: "mov")!))
        layers.frame = videoContainer.bounds
        layers.videoGravity = .resizeAspect
        videoContainer.layer.addSublayer(layers)
        layers.player = player
        
        
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(rewindVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        player.play()
    }
    
    @objc func rewindVideo(notification: Notification){
        layers.player?.seek(to: .zero)
    }
    
    private func timeSpend(){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter(){
        count += 1
        let time = secondsToHoursMinutes(seconds: count)
        timeString = makeTimeString(minutes: time.0, seconds: time.1)
        navigationItem.title = timeString
    }
    
    func secondsToHoursMinutes(seconds:Int)->(Int, Int){
        return((seconds % 3600)/60, (seconds % 3600)%60)
    }
    
    func makeTimeString(minutes:Int, seconds:Int)-> String{
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @objc func quitAlertVC(){
        let quitActionSheet = UIAlertController(title: "", message: "Are you sure you wan to stop exercise?", preferredStyle: .actionSheet)
        let quitAction = UIAlertAction(title: "Quit", style: .default, handler: .none)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        quitActionSheet.addAction(quitAction)
        quitActionSheet.addAction(cancelAction)
        
        present(quitActionSheet, animated: true, completion: nil)
        
    }
}
extension UIView {
    func applyBlurEffect(_ view:UIView) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}

struct Exercise {
    let exerciseTitle:String
    let repetition:Int
    let videoName:String
    let exerciseType:String
    
}
