//
//  UUIDKey.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-16.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import CoreBluetooth

let service_UUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
let Characteristic_uuid_Tx = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
let Characteristic_uuid_Rx = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

let BLEService_UUID = CBUUID(string: service_UUID)
let BLE_Characteristic_uuid_Tx = CBUUID(string: Characteristic_uuid_Tx) //(Property = Write without response)
let BLE_Characteristic_uuid_Rx = CBUUID(string: Characteristic_uuid_Rx) //(Property = read/notify)

