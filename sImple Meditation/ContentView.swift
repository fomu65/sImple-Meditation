//
//  ContentView.swift
//  sImple Meditation
//
//  Created by Ted Hardy on 1/20/20.
//  Copyright © 2020 sImple apps. All rights reserved.
//

import SwiftUI

struct StaticChimeList: Identifiable {
    var id: Int
    var name: String
    var file: String
}

struct ChimeRow: View {
    var chime: StaticChimeList
    var body: some View {
        Text("\(chime.name)")
    }
}

struct ReminderIntervals: Identifiable {
    var id: Int
    var text: String
    var duration: Int
}

struct Intervals: View {
    var interval: ReminderIntervals
    var body: some View {
        Text("\(interval.text)")
    }
}

struct ContentView: View {
    @State var timer:  Timer?
    @State var showingMeditationView = false
    @State var startReminder: Bool = false
    @State var startReminderSelected = ""
    @State var endReminder: Bool = false
    @State var endReminderSelected = ""
    @State var intervalReminder: Bool = false
    @State var intervalReminderSelected = ""
    @State var intervalReminderInterval = 0.0
    @State var durationMinValue = 0.0
    @State var durationMaxValue = 120.0
    @State var duration: Double = 20
    
    static let chimes:[StaticChimeList] = [
        StaticChimeList(id: 0, name: "Ancient Bowl", file:"ancient-bowl.mp3"),
        StaticChimeList(id: 1, name: "Bell", file:"bell-ding.mp3"),
        StaticChimeList(id: 2, name: "Bronze Bell", file:"bronze-bell.mp3"),
        StaticChimeList(id: 3, name: "Glass Bowl", file:"glass-bowl.mp3"),
        StaticChimeList(id: 4, name: "Low Gong", file:"low-gong.mp3"),
        StaticChimeList(id: 5, name: "Quiet Wind Chimes", file:"quiet-wind-chimes.mp3"),
        StaticChimeList(id: 6, name: "Singing Bowl", file:"singing-bowl.mp3"),
        StaticChimeList(id: 7, name: "Singing Chimes", file:"singing-chimes.mp3"),
        StaticChimeList(id: 8, name: "Soft Wind Chimes", file:"soft-wind-chimes.mp3"),
    ]
    
    static let intervals:[ReminderIntervals] = [
        ReminderIntervals(id: 0, text: "Every minute", duration: 1),
        ReminderIntervals(id: 1, text: "3 minutes", duration: 3),
        ReminderIntervals(id: 2, text: "5 minutes", duration: 5),
        ReminderIntervals(id: 3, text: "7 minutes", duration: 7),
        ReminderIntervals(id: 4, text: "10 minutes", duration: 10),
    ]
    
    var timerMinValue: Double = 5.0
    var timerMaxValue: Double = 120.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Meditation Length")) {
                    VStack {
                        HStack {
                        Text("\(Int(timerMinValue))")
                            Slider(value: $duration
                                , in: timerMinValue...timerMaxValue/*, step: 0.1*/)
                            .frame(height: 20, alignment: .center)
                        Text("\(Int(timerMaxValue))")
                        }.padding()
                        Text("\(Int(duration)) minutes")
                    }
                }
                Section {
                        Toggle(isOn: $startReminder) {
                        Text("Use starting chime?")
                        }
                        Picker("Start Reminder:", selection: $startReminderSelected) {
                            ForEach(ContentView.chimes, id: \.id) {
                                Text($0.name).tag($0.name)
                            }
                        }.disabled(!startReminder)
                    }
                    Section {
                        Toggle(isOn: $endReminder) {
                            Text("Use ending chime?")
                        }
                        Picker("End Reminder:", selection: $endReminderSelected) {
                            ForEach(ContentView.chimes, id: \.id) {
                                Text($0.name).tag($0.name)
                            }
                        }.disabled(!endReminder)
                    }
                    Section {
                        Toggle(isOn: $intervalReminder) {
                            Text("Use reminder chime?")
                        }
                        Picker("Repeating Reminder:", selection: $intervalReminderSelected) {
                            ForEach(ContentView.chimes, id: \.id) {
                                Text($0.name).tag($0.name)
                            }
                        }.disabled(!intervalReminder)
                        /*Picker("Reminder Interval", selection: $intervalReminderInterval) {
                            ForEach(ContentView.intervals, id: \.id) {
                                Text($0.text).tag($0.text)
                            }
                        }.disabled(!intervalReminder)*/
                    }
                Section {
                            Button(action: {
                                //self.showingMeditationView.toggle()
                                print("Start Meditation Button Tapped")
                            }) {
                                HStack {
                                    Image(systemName: "wind")
                                        .font(.title)
                                    Text("Meditate")
                                        .fontWeight(.semibold)
                                        .font(.title)
                                }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(40)
                            /*.sheet(isPresented: $showingMeditationView) {
                                MeditationView()
                                }*/
                            }
                }
            }.navigationBarTitle("sImple", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
