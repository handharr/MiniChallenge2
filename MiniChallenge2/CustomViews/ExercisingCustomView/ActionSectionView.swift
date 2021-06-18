//
//  ActionSectionView.swift
//  XibTutorial
//
//  Created by Bayu Triharyanto on 08/06/21.
//

import UIKit
import AVFoundation

protocol ActionSectionDelegate:AnyObject {
    func nextExercise()
}

class ActionSectionView: UIView {
    
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var setTitle: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var exerciseType: UILabel?
    @IBOutlet weak var smallNextIcon: UIImageView!
    @IBOutlet weak var nextExerciseLabel: UILabel!
    @IBOutlet weak var setCounterLabel: UILabel!
    @IBOutlet weak var exerciseCounterLabel: UILabel!
    
    var timer : Timer?
    var second = 0
    var isActive = false
    var exerciseData:Exercise?
    var exerciseNum:Int?
    var totalExercise = 0
    var audio: AVAudioPlayer?
    
    
    var delegate:ActionSectionDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("ActionSectionView", owner: self, options: nil)! [0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    
    func setUpView(data: Exercise, exerciseNumber:Int){
        exerciseData = data
        self.exerciseNum = exerciseNumber
        exerciseCounterLabel.text = "\(exerciseNumber+1)" + "/" + "\(totalExercise)"
//        setCounterLabel.text = "\(currentSet)/\(totalSet)"
        if data.exerciseType == "timeBase"{
//            timer.fire()
            exerciseType?.text = data.exerciseTitle
            timeLabel?.text = String(data.repetition)
            second = data.repetition
            timerForEachExerCise()
        }
        else if data.exerciseType == "countBase"{
            exerciseType?.text = "\(data.repetition) \(data.exerciseTitle)"
//            second =
            timer?.invalidate()
            timeLabel?.text = "-"
            
        }
        
    }
    func timerForEachExerCise(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(ActionSectionView.timerClass) , userInfo: nil, repeats: true)
    }

    @IBAction func startBtn(_ sender: Any) {
        guard let exercise = exerciseData else {
            return
        }
        if exercise.exerciseType == "countBase"{
            print("countbase")
        }
        else if exercise.exerciseType == "timeBase"{
            if isActive{
                isActive = false
                startBtn.setImage(#imageLiteral(resourceName: "pauseBtn"), for: .normal)
                timer?.invalidate()
            }
            else{
                isActive = true
                startBtn.setImage(#imageLiteral(resourceName: "playBtn"), for: .normal)
                timer?.invalidate()
            }
        }
    }

    @IBAction func nextBtn(_ sender: Any) {
        timer?.invalidate()
        delegate?.nextExercise()
    }
    
    @objc func timerClass(){
        second -= 1
        timeLabel?.text = "\(second)"
        if second == 11{
            timerSound()
        }
        else if second == 0{
            timer?.invalidate()
            delegate?.nextExercise()
        }
    }
    
    func timerSound(){
        let pathSound = Bundle.main.path(forResource: "timerCountdown", ofType: "wav")!
        let url = URL(fileURLWithPath: pathSound)
        
        do{
            audio = try AVAudioPlayer(contentsOf: url)
            audio?.play()
        }
        catch{
            print(error)
        }
    }
}
