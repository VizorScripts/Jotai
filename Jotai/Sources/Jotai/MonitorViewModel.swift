// ViewModels/MonitorViewModel.swift
import Foundation
import Combine

class MonitorViewModel: ObservableObject {
    @Published var monitors: [Monitor] = []
    private var timerCancellable: AnyCancellable?
    
    init() {
        loadMonitors()
        startMonitoring()
    }
    
    /// Loads monitors from persistent storage (or creates sample monitors if none exist).
    func loadMonitors() {
        monitors = PersistenceManager.loadMonitors()
        if monitors.isEmpty {
            let sampleMonitors = [
                Monitor(name: "Example", url: URL(string: "https://example.com")!),
                Monitor(name: "Google", url: URL(string: "https://google.com")!)
            ]
            monitors = sampleMonitors
            PersistenceManager.saveMonitors(monitors)
        }
    }
    
    /// Sets up a timer to update each monitor every 60 seconds.
    func startMonitoring() {
        timerCancellable = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateMonitors()
            }
        updateMonitors() // initial update
    }
    
    /// Iterates through monitors and updates their status.
    func updateMonitors() {
        for (index, monitor) in monitors.enumerated() {
            MonitorService.checkStatus(for: monitor) { [weak self] updatedMonitor in
                guard let self = self else { return }
                self.monitors[index] = updatedMonitor
                PersistenceManager.saveMonitors(self.monitors)
            }
        }
    }
    
    /// Adds a new monitor and saves it.
    func addMonitor(name: String, urlString: String) {
        guard let url = URL(string: urlString) else {
            print("MonitorViewModel: Invalid URL string: \(urlString)")
            return
        }
        let newMonitor = Monitor(name: name, url: url)
        monitors.append(newMonitor)
        PersistenceManager.saveMonitors(monitors)
    }
}
