// Core/Networking/MonitorService.swift
import Foundation

class MonitorService {
    /// Checks the status of a monitor by performing an HTTP GET request.
    static func checkStatus(for monitor: Monitor, completion: @escaping (Monitor) -> Void) {
        var updatedMonitor = monitor
        let startTime = Date()

        let task = URLSession.shared.dataTask(with: monitor.url) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("MonitorService: Error for \(monitor.name): \(error.localizedDescription)")
                    updatedMonitor.status = .offline
                    updatedMonitor.responseTime = nil
                } else if let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) {
                    updatedMonitor.status = .online
                    updatedMonitor.responseTime = Date().timeIntervalSince(startTime) * 1000
                } else {
                    updatedMonitor.status = .offline
                    updatedMonitor.responseTime = nil
                }
                completion(updatedMonitor)
            }
        }
        task.resume()
    }
}
