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
    
    var exerciseList = [Exercise]()
    var position = 0
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var actionContainer: ActionSectionView!
    
    //    var exerciseList = [Exercise]()
    //    var position = 0
    var timer = Timer()
    var exerciseTimer = Timer()
    var count = 0
    var isActive = false
    var totalSet = 3
    var currentSet = 1
    
    let subView:VideoSectionView = {
        let subView = VideoSectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 545))
        return subView
    }()
    lazy var subView2:ActionSectionView = {
        let subView = ActionSectionView(frame: CGRect(x: -17, y: 420, width: 420, height: 300))
        subView.delegate = self
        return subView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureExercise()
        self.videoContainer.addSubview(subView)
        self.view.addSubview(subView2)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent
        blurView.applyBlurEffect(blurView)
//        actionContainer.setUpNewView()
        nextExer()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(quitAlertVC))
        timeSpend()
        playVideo()
    }
    
    func configureExercise(){
        exerciseList.append(Exercise(exerciseTitle: "Crunches", repetition: 5, videoName: "crunches", exerciseType:"timeBase"))
        exerciseList.append(Exercise(exerciseTitle: "PushUp", repetition: 8, videoName: "Push up", exerciseType:"countBase"))
        exerciseList.append(Exercise(exerciseTitle: "SitUp", repetition: 5, videoName: "sit up", exerciseType:"timeBase"))
    }
    func nextExer(){
        if position < exerciseList.count{
            subView2.setUpView(data: exerciseList[position], exerciseNumber: position)
            playVideo()
        }
        else if position == exerciseList.count && currentSet < totalSet{
            position = 0
            currentSet += 1
            subView2.setCounterLabel.text = "\(currentSet)/\(totalSet)"
            subView2.setUpView(data: exerciseList[position], exerciseNumber: position)
        }
        else if position == exerciseList.count && currentSet == totalSet{
            closeButton()
            timer.invalidate()
        }
        
    }
    var timerExer = 0
    
//    func setUpView(data: Exercise){
//        subView2.exerciseCounterLabel.text = "\(position+1)" + "/" + "\(exerciseList.count)"
//        if data.exerciseType == "timeBase"{
//            subView2.exerciseType?.text = data.exerciseTitle
//            subView2.timeLabel?.text = String(data.repetition)
//            subView2.second = data.repetition ?? 0
//            subView2.timerForEachExerCise()
//        }
//        else if data.exerciseType == "countBase"{
//            subView2.exerciseType?.text = "\(data.repetition) \(data.exerciseTitle)" ?? "exercise"
//            subView2.timeLabel?.text = "-"
//            subView2.stopTimerforCountBase()
//        }
//        
//    }
    
    @objc private func closeButton(){
        let vc = CongratulationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    var layers = AVPlayerLayer()
    func playVideo(){
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: exerciseList[position].videoName, ofType: "mov")!))
        layers.player = player
        layers.frame = videoContainer.bounds
        layers.videoGravity = .resizeAspect
        videoContainer.layer.addSublayer(layers)
        
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
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
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
