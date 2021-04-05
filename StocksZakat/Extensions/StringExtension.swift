//
//  StringExtension.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 05.04.21.
//

import Foundation

class countCoder{
    func suffixNumber(number:NSNumber) -> NSString {

        var num:Double = number.doubleValue
        let sign = ((num < 0) ? "-" : "" )

        num = fabs(num)

        if (num < 1000.0){
            return "\(sign)\(num)" as NSString
        }

        let exp:Int = Int(log10(num) / 3.0 ) //log10(1000));

        let units:[String] = ["K","M","B","T","aa","ab","ac","ad","ae","af","ag","ah","ai"]

        let roundedNum:Double = (10 * num / pow(1000.0,Double(exp))) / 10
        print(exp-1)
        return "\(sign)\(roundedNum)\(units[exp-1])" as NSString
    }
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",",","."]
        return Set(self).isSubset(of: nums)
    }
}
