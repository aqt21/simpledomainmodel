//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String

  public func convert(_ to: String) -> Money {
    if currency == "USD" {
        if to == "GBP" {
            let converted = Money(amount: amount / 2, currency:"GBP")
            return converted
        }
        if to == "EUR" {
            let converted = Money(amount: amount / 2 * 3, currency:"EUR")
            return converted
        }
        if to == "CAN" {
            let converted = Money(amount: amount / 4 * 5, currency:"CAN")
            return converted
        }
    } else
    if currency == "GBP" {
        if to == "USD" {
            let converted = Money(amount: amount * 2, currency:"USD")
            return converted
        }
        if to == "EUR" {
            let converted = Money(amount: amount * 3, currency:"EUR")
            return converted
        }
        if to == "CAN" {
            let converted = Money(amount: amount * 5, currency:"CAN")
            return converted
        }
    }else
    if currency == "EUR" {
        if to == "USD" {
            let converted = Money(amount: amount / 3 * 2, currency:"USD")
            return converted
        }
        if to == "GBP" {
            let converted = Money(amount: amount / 3, currency:"GBP")
            return converted
        }
        if to == "CAN" {
            let converted = Money(amount: amount / 3 * 5, currency:"CAN")
            return converted
        }
    }else
    if currency == "CAN" {
        if to == "USD" {
            let converted = Money(amount: amount / 5 * 4, currency:"USD")
            return converted
        }
        if to == "GBP" {
            let converted = Money(amount: amount / 5 * 2, currency:"GBP")
            return converted
        }
        if to == "EUR" {
            let converted = Money(amount: amount / 5 * 6, currency:"EUR")
            return converted
        }
    }
    let converted = Money(amount: 0, currency:"USD")
    return converted
  }
  
  public func add(_ to: Money) -> Money {
    if to.currency == currency {
        let added = Money(amount: amount + to.amount, currency: to.currency)
        return added
    } else {
        let converted = convert(to.currency)
        let added = Money(amount: to.amount + converted.amount, currency: to.currency)
        return added
    }
  }
  public func subtract(_ from: Money) -> Money {
    if from.currency == currency {
        let added = Money(amount: from.amount - amount, currency: currency)
        return added
    } else {
        let converted = convert(from.currency)
        let added = Money(amount: from.amount - converted.amount, currency: from.currency)
        return added
    }
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let num):
        return Int(Double(hours) * num)
    case .Salary(let num):
        return num
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let num):
        self.type = JobType.Hourly(num + amt)
    case .Salary(let num):
        self.type = JobType.Salary(num + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job
    }
    set(value) {
        if self.age > 15 {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse
    }
    set(value) {
        if self.age > 21 {
             self._spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    let personDescription = "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(_job?.type) spouse:\(_spouse)]"
    print(personDescription)
    return personDescription
  }
}

//////////////////////////////////////
//// Family
////
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if members[0].age >= 21 || members[1].age >= 21 {
        members.append(child)
        return true
    }
    return false
  }
  
  open func householdIncome() -> Int {
    var totalIncome = 0
    for i in 0 ... members.count - 1 {
        if members[i].job != nil {
            print( members[i].job!.calculateIncome(2000))
            totalIncome += members[i].job!.calculateIncome(2000)
        }
    }
    
    return totalIncome
  }
}





