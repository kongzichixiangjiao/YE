//
//  YYSwiftDateViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/30.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import SwiftDate

class YYSwiftDateViewController: YYXIBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "SwiftDate"
        
        let region = Region(tz: TimeZoneName.gmt, cal: CalendarName.chinese, loc: LocaleName.chinese)
        Date.setDefaultRegion(region)
        print(region.description)
        print(region.locale)
        print(region.calendar)
        print(region.firstWeekday)
        
        let dateInRegion = DateInRegion(absoluteDate: Date(), in: region)
        print("absoluteDate == \(dateInRegion.absoluteDate)")
        print("era == \(dateInRegion.era)")
        print("year == \(dateInRegion.year)")
        print("month == \(dateInRegion.month)")
        print("weekday == \(dateInRegion.weekday)")
        print("weekday == \(dateInRegion.weekOfYear)")
        print("weekday == \(dateInRegion.weekOfMonth)")
        print("weekday == \(dateInRegion.weekdayName)")
        print("day == \(dateInRegion.day)")
        print("hour == \(dateInRegion.hour)")
        print("nearestHour == \(dateInRegion.nearestHour)")
        print("minute == \(dateInRegion.minute)")
        print("second == \(dateInRegion.second)")
        print("nanosecond == \(dateInRegion.nanosecond)")
        print("yearForWeekOfYear == \(dateInRegion.yearForWeekOfYear)")

        print(YYDate.currentDate)
        print(YYDate.systemDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
