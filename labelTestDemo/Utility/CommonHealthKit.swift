//
//  CommonHealthKit.swift
//  labelTestDemo
//
//  Created by PCQ184 on 30/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import HealthKit
import MapKit

class HealthKitInterfaceBasic {
    
    // A placeholder for a conduit to all HealthKit data
    let healthKitDataStore: HKHealthStore?
    var vw = MKAnnotationView()
    // Get a user's physical property that won't change
    let genderCharacteristic = HKCharacteristicType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)
    
    // STEP 4: for flexibility, the API allows us to ask for
    // multiple characteristics at once
    let readableHKCharacteristicTypes: Set<HKCharacteristicType>?
    
    init() {
        
        // STEP 5: Make sure HealthKit is available
        if HKHealthStore.isHealthDataAvailable() {
            // STEP 6: Create one instance of the HealthKit store
            // per app; it's the conduit to all HealthKit data
            self.healthKitDataStore = HKHealthStore()
            // STEP 7: I create a Set of one as that's what the call wants
            readableHKCharacteristicTypes = [genderCharacteristic!]
            // STEP 8: request user permission to read gender and
            // then read the value asynchronously
            healthKitDataStore?.requestAuthorization(toShare: nil,
                                                     read: readableHKCharacteristicTypes,
                                                     completion: { (success, error) -> Void in
                                                        if success {
                                                            print("Successful authorization.")
                                                            // STEP 9.1: read gender data (see below)
                                                            self.readGenderType()
                                                        } else {
                                                            print(error.debugDescription)
                                                        }
            })
            
        } // end if HKHealthStore.isHealthDataAvailable()
            
        else {
            self.healthKitDataStore = nil
            readableHKCharacteristicTypes = nil
        }
    }
    
    // STEP 9.2: actual code to read gender data
    func readGenderType() -> Void {
        
        do {
            let genderType = try self.healthKitDataStore?.biologicalSex()
            
            if genderType?.biologicalSex == .female {
                print("Gender is female.")
            }
            else if genderType?.biologicalSex == .male {
                print("Gender is male.")
            }
            else {
                print("Gender is unspecified.")
            }
            
        }
        catch {
            print("Error looking up gender.")
        }
        
    } // end func readGenderType
}
