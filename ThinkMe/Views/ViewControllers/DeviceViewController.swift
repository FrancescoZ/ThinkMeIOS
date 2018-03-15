//
//  DeviceViewController.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//
import UIKit
import CoreBluetooth
import SwiftKeychainWrapper

class DeviceViewController: UIViewController {
  
  @IBOutlet weak var sourceView: UIImageView!
  @IBOutlet weak var infoLabel: UILabel!

  var manager:CBCentralManager!
  var connectedPeripheral:CBPeripheral!
  var TransmitCharacteristic:CBCharacteristic?
  
  let deviceName = "6E400001-B5A3-F393-E0A9-E50E24DCCA90"
  let serviceUUID = CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
  let charTxUUID = CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
  let charRxUUID = CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
  
  let pulsator = Pulsator()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sourceView.isHidden = true
    sourceView.layer.superlayer?.insertSublayer(pulsator, below: sourceView.layer)
    pulsator.start()
    
    manager = CBCentralManager(delegate: self, queue: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.layer.layoutIfNeeded()
    pulsator.position = sourceView.layer.position
  }
  
  @IBAction func sendTouch(_ sender: Any) {
    sendValues(value:67)
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
}

extension DeviceViewController: CBCentralManagerDelegate,CBPeripheralDelegate{
  //MARK:- scan for devices
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    
    switch central.state {
    case .poweredOn:
      print("powered on")
      central.scanForPeripherals(withServices: nil, options: nil)
    case .poweredOff:
      print("powered off")
    case .resetting:
      print("resetting")
    case .unauthorized:
      print("unauthorized")
    case .unknown:
      print("unknown")
    case .unsupported:
      print("unsupported")
    }
  }

  //MARK:- connect to a device
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    let device = advertisementData[CBAdvertisementDataLocalNameKey] as? String
    if (device?.contains(deviceName)) != nil {
      self.manager.stopScan()
      sourceView.isHidden = false
      infoLabel.isHidden = true
      self.connectedPeripheral = peripheral
      self.connectedPeripheral.delegate = self
      manager.connect(peripheral, options: nil)
    }
  }
  
  //MARK:- get services on devices
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    peripheral.discoverServices(nil)
  }

  //MARK:- disconnect
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    central.scanForPeripherals(withServices: nil, options: nil)
  }

  //MARK:- get characteristics
  func peripheral(
    _ peripheral: CBPeripheral,
    didDiscoverServices error: Error?) {
    for service in peripheral.services! {
      let thisService = service as CBService

      if service.uuid == self.serviceUUID {
        peripheral.discoverCharacteristics(
          nil,
          for: thisService
        )
      }
    }
  }

   //MARK:- notification
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
    for characteristic in service.characteristics! {
      let thisCharacteristic = characteristic as CBCharacteristic

      if thisCharacteristic.uuid == charRxUUID {
        peripheral.readValue(for: thisCharacteristic)
        peripheral.setNotifyValue(
          true,
          for: thisCharacteristic
        )
      } else if thisCharacteristic.uuid == charTxUUID {
        TransmitCharacteristic = thisCharacteristic
        peripheral.readValue(for: thisCharacteristic)
      }
    }
  }

  //MARK:- characteristic change
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    if pulsator.isPulsating {
      pulsator.stop()
      
      
    }else {
      pulsator.start()
      pulsator.numPulse = 10
      pulsator.radius = CGFloat(200)
      pulsator.animationDuration = 10
    }
  }
  //MARK:- send data
  func sendValues(value: UInt8){
    let data = Data(bytes: [value])
    guard let ledChar = TransmitCharacteristic else {
      return
    }
    connectedPeripheral.writeValue(data, for: ledChar, type: .withResponse)
  }
}

