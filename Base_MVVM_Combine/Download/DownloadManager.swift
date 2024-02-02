//
//  DownloadManager.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import RealmSwift
import Combine

final class DownloadManager {
  static let shared = DownloadManager()
  
  let change = PassthroughSubject<Any?, Never>()
  private let maxThread = 4
  private let timeInterval = 0.1
  private var queue = [BaseObject]()
  private var threads = [Thread]() {
    didSet {
      change.send(nil)
    }
  }
  private var isLoading = false
  private var timer: Timer?
}

extension DownloadManager {
  func load(_ objects: [BaseObject]) {
    self.queue += objects
    guard !isLoading else {
      return
    }
    fire()
  }
  
  func loadPriority(_ object: BaseObject) {
    guard let firstIndex = queue.firstIndex(where: { $0.id == object.id }) else {
      return
    }
    queue.remove(at: firstIndex)
    queue.insert(object, at: 0)
    if threads.count == maxThread {
      let lastThread = threads.first
      lastThread?.cancel()
    }
  }
}

extension DownloadManager {
  private func invalidate() {
    timer?.invalidate()
    self.timer = nil
    self.isLoading = false
  }
  
  private func fire() {
    DispatchQueue.main.async { [weak self] in
      guard let self else {
        return
      }
      invalidate()
      self.isLoading = true
      self.timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                        target: self,
                                        selector: #selector(addThread),
                                        userInfo: nil,
                                        repeats: true)
    }
  }
  
  @objc private func addThread() {
    guard NetworkMonitor.shared.isConnected else {
      return
    }
    guard threads.count < maxThread else {
      return
    }
    guard !queue.isEmpty else {
      if threads.isEmpty {
        invalidate()
      }
      return
    }
    let object = queue.removeFirst()
    
    guard let dataURL = object.dataURL else {
      return
    }
      
    let thread = Thread(id: dataURL)
    thread.load(object: object) { [weak self] in
      guard let self else {
        return
      }
      threads.removeAll { $0.id == thread.id }
    } errored: { [weak self] in
      guard let self else {
        return
      }
      threads.removeAll { $0.id == thread.id }
      queue.append(object)
    }
    threads.append(thread)
  }
}
