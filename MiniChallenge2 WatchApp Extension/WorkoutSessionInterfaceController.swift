//
//  WorkoutSessionInterfaceController.swift
//  MiniChallenge2 WatchApp Extension
//
//  Created by Jackie Leonardy on 15/06/21.
//

import WatchKit
import HealthKit
import Combine
import WatchConnectivity

class WorkoutSessionInterfaceController: WKInterfaceController{
    
    @IBOutlet weak var distanceRunning: WKInterfaceLabel!
    @IBOutlet weak var heartBeat: WKInterfaceLabel!
    @IBOutlet weak var timer: WKInterfaceLabel!
    @IBOutlet weak var calories: WKInterfaceLabel!
    @IBOutlet weak var averageSpeed: WKInterfaceLabel!
    
    
    var watchInterface = InterfaceController()
    var watchSession: WCSession = WCSession.default
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!
    
    @Published var heartrate: Double = 0
    @Published var activeCalories: Double = 0
    @Published var distance: Double = 0
    @Published var elapsedSeconds: Int = 0
    @Published var speed: Double = 0
    
    var start: Date = Date()
    var cancellable: Cancellable?
    var accumulatedTime: Int = 0
    
    var running: Bool = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.becomeCurrentPage()
//        watchInterface.delegate = self
        setUpData()
        requestAuthorization()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseTriggered), name: NSNotification.Name("Pause Triggered"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(skipTriggered), name: NSNotification.Name("Skip Triggered"), object: nil)
    }
    
    
    @objc
    func pauseTriggered(){
        if running {
            self.pauseWorkout()
        } else {
            resumeWorkout()
        }
    }
    
    @objc
    func skipTriggered(){
        self.endWorkout()
    }
    
    override func willActivate() {
        super.willActivate()
        watchSession.delegate = self
        watchSession.activate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func setUpData(){
        distanceRunning.setText(String(format: "%.1f", distance))
        heartBeat.setText(String(format: "%.1f", heartrate))
        timer.setText("\(elapsedTimeString(elapsed: secondsToHoursMinutesSeconds(seconds: elapsedSeconds)))")
        calories.setText(String(format: "%.1f", activeCalories))
        averageSpeed.setText(String(format: "%.1f", distance))
    }
    
    func requestAuthorization() {
        let typesToShare: Set = [
            HKQuantityType.workoutType(),
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            self.startWorkout()
        }
    }
    
    func setUpTimer() {
        start = Date()
        cancellable = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedSeconds = self.incrementElapsedTime()
                DispatchQueue.main.async {
                    self.timer.setText("\(self.elapsedTimeString(elapsed: self.secondsToHoursMinutesSeconds(seconds: self.elapsedSeconds)))")
                }
                
            }
    }
    
    func incrementElapsedTime() -> Int {
        let runningTime: Int = Int(-1 * (self.start.timeIntervalSinceNow))
        return self.accumulatedTime + runningTime
    }
    
    func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Convert the seconds, minutes, hours into a string.
    func elapsedTimeString(elapsed: (h: Int, m: Int, s: Int)) -> String {
        return String(format: "%02d:%02d", elapsed.m, elapsed.s)
    }
    
    func workoutConfiguration() -> HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        return configuration
    }
    
    func startWorkout() {
        setUpTimer()
        self.running = true
        
        // Bikin session baru dan membuat workout builder
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.workoutConfiguration())
            builder = session.associatedWorkoutBuilder()
        } catch {
            return
        }
        
        session.delegate = self
        builder.delegate = self
        
        builder.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                     workoutConfiguration: workoutConfiguration())
        
        //mulai workout session dan builder akan mengambil data2
        session.startActivity(with: Date())
        builder.beginCollection(withStart: Date()) { (success, error) in
            
        }
    }
    
    func pauseWorkout() {
        // Pause the workout.
        session.pause()
        // Stop the timer.
        cancellable?.cancel()
        // Save the elapsed time.
        accumulatedTime = elapsedSeconds
        running = false
    }
    
    func resumeWorkout() {
        // Resume the workout.
        session.resume()
        // Start the timer.
        setUpTimer()
        running = true
    }
    
    func endWorkout() {
        // End the workout session.
        session.end()
        cancellable?.cancel()
    }
    
    func resetWorkout() {
        // Reset the published values.
        DispatchQueue.main.async {
            self.elapsedSeconds = 0
            self.activeCalories = 0
            self.heartrate = 0
            self.distance = 0
        }
    }
    
    // MARK: - Update the UI
    // Update the published values.
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                /// - Tag: SetLabel
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
//                print("Heart Rate Unit: " + "\(heartRateUnit)")
                let value = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
//                print("Heart Rate Value: " + "\(value)")
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.heartrate = roundedValue
                
                DispatchQueue.main.async {
                    self.heartBeat.setText(String(format: "%.1f", self.heartrate))
                }
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                let value = statistics.sumQuantity()?.doubleValue(for: energyUnit)
                self.activeCalories = Double( round( 1 * value! ) / 1 )
                DispatchQueue.main.async {
                    self.calories.setText(String(format: "%.1f", self.activeCalories))
                }
//                let voUnit = (HKUnit.liter().unitDivided(by: HKUnit.pound())).unitDivided(by: HKUnit.minute())
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning):
                let meterUnit = HKUnit.meter()
                let value = statistics.sumQuantity()?.doubleValue(for: meterUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )/1000
                self.distance = roundedValue
                DispatchQueue.main.async {
                    self.distanceRunning.setText(String(format: "%.2f", roundedValue))
                }
                return
            default:
                return
            }
        }
        
        do{
            try watchSession.updateApplicationContext([
                "heartRate": self.heartrate,
                "activeEnergy": self.activeCalories,
                "workoutTimer": "\(self.elapsedTimeString(elapsed: self.secondsToHoursMinutesSeconds(seconds: self.elapsedSeconds)))",
                "runningSpeed": self.speed,
                "runningDistance": self.distance
            ])
            print("distance=> \(self.distance)")
        }catch{}
    }
}

extension WorkoutSessionInterfaceController: RunningSessionDelegate {
    func stopDidTapped(isRunning: Bool) {
        if isRunning {
            self.pauseWorkout()
        } else {
            resumeWorkout()
        }
    }
    func workoutDidCancel() {
    }
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutSessionInterfaceController: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        if toState == .ended {
            
            if self.elapsedSeconds < 59 {
                builder.endCollection(withEnd: Date()) { (success, error) in
                    self.builder.finishWorkout { (workout, error) in
                        self.resetWorkout()
                    }
                }
                return
            }
            else {
                builder.endCollection(withEnd: Date()) { (success, error) in
                    self.builder.finishWorkout { (workout, error) in
                        self.resetWorkout()
                    }
                }
            }
            
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension WorkoutSessionInterfaceController: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
//        print("collected type: \(collectedTypes)")
        //mengecek tipe koleksi apa aja yang sudah kita dapatkan dari reading dan updating dari healthStore
        for type in collectedTypes {
            //mengecek apakah collectedType yang kita dapatkan adalah quantity(diskrit dan bukan subjektif) atau bukan
            print("type: \(type)")
            
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }
            
            /// - Tag: GetStatistics
            //mengecek statistik untuk quantity type, dan jika ketemu berarti data didapatkan
            let statistics = workoutBuilder.statistics(for: quantityType)
            print(quantityType)
            // Update the published values.
            updateForStatistics(statistics)
        }
    }
}

extension WorkoutSessionInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let receivedData = applicationContext["quit"] as? String{
            self.dismiss()
            print(receivedData)
        }
    }
}
