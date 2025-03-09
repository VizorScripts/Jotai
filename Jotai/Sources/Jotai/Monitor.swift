// Models/Monitor.swift
import Foundation

struct Monitor: Identifiable, Codable {
    let id: UUID
    var name: String
    var url: URL
    var status: MonitorStatus
    var responseTime: Double? // milliseconds
    
    init(id: UUID = UUID(), name: String, url: URL, status: MonitorStatus = .unknown, responseTime: Double? = nil) {
        self.id = id
        self.name = name
        self.url = url
        self.status = status
        self.responseTime = responseTime
    }
}
