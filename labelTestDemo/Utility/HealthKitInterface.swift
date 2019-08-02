//
//  HealthKitInterface.swift
//  labelTestDemo
//
//  Created by PCQ184 on 29/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitInterface
{
    
    // STEP 2: a placeholder for a conduit to all HealthKit data
    let healthKitDataStore: HKHealthStore?
    
    // STEP 3: create member properties that we'll use to ask
    // If we can read and write heart rate data
    let readableHKQuantityTypes: Set<HKQuantityType>?
    let writeableHKQuantityTypes: Set<HKQuantityType>?
    
    init() {
        
        // STEP 4: make sure HealthKit is available
        if HKHealthStore.isHealthDataAvailable() {
            
            // STEP 5: create one instance of the HealthKit store
            // Per app; it's the conduit to all HealthKit data
            self.healthKitDataStore = HKHealthStore()
            
            // STEP 6: create two Sets of HKQuantityTypes representing
            // Heart rate data; one for reading, one for writing
            readableHKQuantityTypes = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
            writeableHKQuantityTypes = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
            
            // STEP 7: ask user for permission to read and write
            // Heart rate data
            healthKitDataStore?.requestAuthorization(toShare: writeableHKQuantityTypes,
                                                     read: readableHKQuantityTypes,
                                                     completion: { (success, error) -> Void in
                                                        if success {
                                                            print("Successful authorization.")
                                                            self.fetchLatestHeartRateSample {
                                                                samplesOrNil in
                                                                if let samples = samplesOrNil {
                                                                    for heartRateSamples in samples {
                                                                        print(heartRateSamples)
                                                                    }
                                                                } else {
                                                                    print("No heart rate sample available.")
                                                                }
                                                            }
                                                        } else {
                                                            print(error.debugDescription)
                                                        }
            })
        } // End if HKHealthStore.isHealthDataAvailable()
            
        else {
            self.healthKitDataStore = nil
            self.readableHKQuantityTypes = nil
            self.writeableHKQuantityTypes = nil
        }        
    } // End init()
    
    // STEP 8.0: This is my wrapper for writing one heart
    // Rate sample at a time to the HKHealthStore
    func writeHeartRateData( heartRate: Int ) -> Void {
        
        // STEP 8.1: "Count units are used to represent raw scalar values. They are often used to represent the number of times an event occurs"
        let heartRateCountUnit = HKUnit.count()
        
        // STEP 8.2: "HealthKit uses quantity objects to store numerical data. When you create a quantity, you provide both the quantity’s value and unit."
        // Beats per minute = heart beats / minute
        let beatsPerMinuteQuantity = HKQuantity(unit: heartRateCountUnit.unitDivided(by: HKUnit.minute()), doubleValue: Double(heartRate))
        
        // STEP 8.3: "HealthKit uses quantity types to create samples that store a numerical value. Use quantity type instances to create quantity samples that you can save in the HealthKit store."
        // Short-hand for HKQuantityTypeIdentifier.heartRate
        let beatsPerMinuteType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        // STEP 8.4: "you can use a quantity sample to record ... the user's current heart rate..."
        let heartRateSampleData = HKQuantitySample(type: beatsPerMinuteType, quantity: beatsPerMinuteQuantity, start: Date(), end: Date())
        
        // STEP 8.5: "Saves an array of objects to the HealthKit store."
        healthKitDataStore?.save([heartRateSampleData]) { (success: Bool, error: Error?) in
            print("Heart rate \(heartRate) saved.")
        }
        
    } // End func writeHeartRateData
    
    // STEP 9.0: This is my wrapper for reading all "recent"
    // Heart rate samples from the HKHealthStore
    func readHeartRateData() -> Void {
        
        // STEP 9.1: Just as in STEP 6, we're telling the `HealthKitStore`
        // That we're interested in reading heart rate data
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        // STEP 9.2: define a query for "recent" heart rate data;
        // In pseudo-SQL, this would look like:

        // SELECT bpm FROM HealthKitStore WHERE qtyTypeID = '.heartRate';
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            if let samples = samplesOrNil {
                
                for heartRateSamples in samples {
                    print(heartRateSamples)
                }
                
            } else {
                print("Heart Rate Samples Are Not Available.")
            }
            
        }
        
        // STEP 9.3: execute the query for heart rate data
        healthKitDataStore?.execute(query)
        
    } // End func readHeartRateData
    
    public func fetchLatestHeartRateSample(
        completion: @escaping (_ samples: [HKQuantitySample]?) -> Void) {
        
        /// Create sample type for the heart rate
        guard let sampleType = HKObjectType
            .quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
        }
        
        /// Predicate for specifiying start and end dates for the query
        let predicate = HKQuery
            .predicateForSamples(
                withStart: Date.distantPast,
                end: Date(),
                options: .strictEndDate)
        
        /// Set sorting by date.
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false)
        
        /// Create the query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) { (_, results, error) in
                
                guard error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                
                completion(results as? [HKQuantitySample])
        }
        
        /// Execute the query in the health store
        let healthStore = HKHealthStore()
        healthStore.execute(query)
    }
    
}
