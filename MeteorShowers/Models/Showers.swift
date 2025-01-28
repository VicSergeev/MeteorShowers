import Foundation

final class Showers {
    // MARK: - Singleton
    static let shared = Showers()
    private init() {}
    
    // MARK: - Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    // MARK: - Meteor Showers Data
    private lazy var showers: [MeteorShower] = {
        [
            MeteorShower(
                name: "Quadrantids",
                dateBegin: dateFormatter.date(from: "01.01.2025")!,
                datePeak: dateFormatter.date(from: "03.01.2025")!,
                dateEnd: dateFormatter.date(from: "05.01.2025")!,
                zhr: 120,
                speed: 41,
                parentBody: "2003 EH1"
            ),
            MeteorShower(
                name: "Lyrids",
                dateBegin: dateFormatter.date(from: "16.04.2025")!,
                datePeak: dateFormatter.date(from: "22.04.2025")!,
                dateEnd: dateFormatter.date(from: "25.04.2025")!,
                zhr: 18,
                speed: 49,
                parentBody: "C/1861 G1 (Thatcher)"
            ),
            MeteorShower(
                name: "Eta Aquariids",
                dateBegin: dateFormatter.date(from: "19.04.2025")!,
                datePeak: dateFormatter.date(from: "05.05.2025")!,
                dateEnd: dateFormatter.date(from: "28.05.2025")!,
                zhr: 50,
                speed: 66,
                parentBody: "1P/Halley"
            ),
            MeteorShower(
                name: "Delta Aquariids",
                dateBegin: dateFormatter.date(from: "12.07.2025")!,
                datePeak: dateFormatter.date(from: "28.07.2025")!,
                dateEnd: dateFormatter.date(from: "23.08.2025")!,
                zhr: 20,
                speed: 41,
                parentBody: "96P/Machholz"
            ),
            MeteorShower(
                name: "Perseids",
                dateBegin: dateFormatter.date(from: "17.07.2025")!,
                datePeak: dateFormatter.date(from: "12.08.2025")!,
                dateEnd: dateFormatter.date(from: "24.08.2025")!,
                zhr: 100,
                speed: 59,
                parentBody: "109P/Swift-Tuttle"
            ),
            MeteorShower(
                name: "Orionids",
                dateBegin: dateFormatter.date(from: "02.10.2025")!,
                datePeak: dateFormatter.date(from: "21.10.2025")!,
                dateEnd: dateFormatter.date(from: "07.11.2025")!,
                zhr: 20,
                speed: 66,
                parentBody: "1P/Halley"
            ),
            MeteorShower(
                name: "Leonids",
                dateBegin: dateFormatter.date(from: "06.11.2025")!,
                datePeak: dateFormatter.date(from: "17.11.2025")!,
                dateEnd: dateFormatter.date(from: "30.11.2025")!,
                zhr: 15,
                speed: 71,
                parentBody: "55P/Tempel-Tuttle"
            ),
            MeteorShower(
                name: "Geminids",
                dateBegin: dateFormatter.date(from: "04.12.2025")!,
                datePeak: dateFormatter.date(from: "14.12.2025")!,
                dateEnd: dateFormatter.date(from: "17.12.2025")!,
                zhr: 150,
                speed: 35,
                parentBody: "3200 Phaethon"
            )
        ]
    }()
    
    // MARK: - Public Methods
    
    /// Returns all meteor showers
    func getAllShowers() -> [MeteorShower] {
        showers
    }
    
    /// Returns current or upcoming meteor shower
    func getCurrentShower() -> MeteorShower? {
        let currentDate = Date()
        return showers.first { shower in
            (shower.dateBegin...shower.dateEnd).contains(currentDate)
        } ?? getNextShower()
    }
    
    /// Returns the next upcoming meteor shower
    func getNextShower() -> MeteorShower? {
        let currentDate = Date()
        return showers.first { shower in
            shower.dateBegin > currentDate
        }
    }
    
    /// Returns meteor shower for specific date
    func getShower(for date: Date) -> MeteorShower? {
        showers.first { shower in
            (shower.dateBegin...shower.dateEnd).contains(date)
        }
    }
}
