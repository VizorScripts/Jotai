// Core/Storage/PersistenceManager.swift
import Foundation

class PersistenceManager {
    private static let monitorsKey = "monitors"

    /// Saves the array of monitors to UserDefaults.
    static func saveMonitors(_ monitors: [Monitor]) {
        do {
            let data = try JSONEncoder().encode(monitors)
            UserDefaults.standard.set(data, forKey: monitorsKey)
        } catch {
            print("PersistenceManager: Failed to save monitors: \(error)")
        }
    }

    /// Loads the monitors from UserDefaults.
    static func loadMonitors() -> [Monitor] {
        guard let data = UserDefaults.standard.data(forKey: monitorsKey) else {
            return []
        }
        do {
            let monitors = try JSONDecoder().decode([Monitor].self, from: data)
            return monitors
        } catch {
            print("PersistenceManager: Failed to load monitors: \(error)")
            return []
        }
    }
}
