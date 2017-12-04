//: [Day 2](http://adventofcode.com/2017/day/2) - [Previous](@previous) - [Next](@next)

import Foundation

let spreadsheet = """
3093    749    3469    142    2049    3537    1596    3035    2424    3982    3290    125    249    131    118    3138
141    677    2705    2404    2887    2860    1123    2714    117    1157    2607    1800    153    130    1794    3272
182    93    2180    114    103    1017    95    580    2179    2470    2487    2806    1574    1325    1898    1706
3753    233    3961    3747    3479    3597    1303    2612    4043    1815    3318    737    197    3943    239    254
113    147    961    157    3514    3045    1270    3528    1369    3377    492    156    1410    3251    1839    1249
3948    3651    888    3631    253    220    4266    1284    3595    237    2138    3799    2319    254    267    1182
399    446    795    653    154    762    140    487    750    457    730    150    175    841    323    492
999    979    103    99    1544    1404    100    1615    840    92    1552    1665    1686    76    113    1700
4049    182    3583    1712    200    3326    3944    715    213    1855    2990    3621    2560    842    249    2082
2610    4749    2723    2915    2189    3911    124    164    1895    3095    3992    134    127    4229    3453    4428
105    692    101    150    193    755    84    185    622    851    706    251    86    408    774    831
238    217    224    1409    1850    2604    363    265    596    2933    2641    2277    803    2557    1399    237
304    247    192    4369    997    5750    85    1248    4718    3888    5228    5116    5880    5348    6052    245
238    373    228    395    86    59    289    87    437    384    233    79    470    403    441    352
151    3473    1435    87    1517    1480    140    2353    1293    118    163    3321    2537    3061    1532    3402
127    375    330    257    220    295    145    335    304    165    151    141    289    256    195    272
"""

// convert to [[Int]]
let rows = spreadsheet
    .split(separator: "\n")
    .map({
        $0.split(separator: " ", omittingEmptySubsequences: true).map({ Int($0)! })
    })

func checksum(_ rows: [[Int]]) -> Int {
    return rows.reduce(0, { (sum: Int, row: [Int]) in
        let min = row.min()!
        let max = row.max()!
        return sum + (max - min)
    })
}

checksum(rows)

func checksum2( _ rows: [[Int]]) -> Int {
    return rows.reduce(0, { (sum: Int, row: [Int]) in
        for (index, cell) in row.enumerated() {
            for otherCell in row.dropFirst(index + 1) {
                let larger = max(cell, otherCell)
                let smaller = min(cell, otherCell)
                if larger % smaller == 0 {
                    return sum + (larger / smaller)
                }
            }
        }
        return sum
    })
}

checksum2(rows)
