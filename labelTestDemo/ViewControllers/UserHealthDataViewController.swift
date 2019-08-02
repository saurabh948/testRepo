//
//  UserHealthDataViewController.swift
//  labelTestDemo
//
//  Created by PCQ184 on 19/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import UIKit
import HealthKit

class UserHealthDataViewController: UIViewController {
    let healthStore = HKHealthStore()
    let healthKitInterface = HealthKitInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        healthKitInterface.fetchLatestHeartRateSample {
//            samplesOrNil in
//            if let samples = samplesOrNil {
//                for heartRateSamples in samples {
//                    print(heartRateSamples)
//                }                
//            } else {
//                print("No heart rate sample available.")
//            }
//        }
        //prepareView()
    }
    
    private func prepareView() {
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
        
        
        
        if HKHealthStore.isHealthDataAvailable() {
            //Healthkit code here...
         
            healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
                if !success {
                    // Handle the error here.
                }
            }
        }
        
        //healthStore.authorizationStatus(for: HKObjectType.workoutType())
    }
}


