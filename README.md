# BlocksSolver
A sliding blocks puzzle solver with an algorithm that can solve most sliding block[rectangular shapes only] problems. 

- The UI shows the moves to take the master block to the goal position
- Astar search algorithm for searching paths
- Manhattan distance used as for calculation of cost to destination/goal.
- Zorbist Hash used for fast lookup of already visited states
- New games can be cofigured in code though no UI is available as yet.
- To configure a new game check the below line in `Game.swift` and add more to the list.
```swift
extension Game {
    static let all: [Game] = [.klotski, .unBlockMe]
}
```

<div>
<tr>
  <td><img src="https://github.com/anilputtabuddhi/BlocksSolver/blob/master/Screenshots/Klotski.png" width="300"/></td>
  <td><img src="https://github.com/anilputtabuddhi/BlocksSolver/blob/master/Screenshots/UnblockMe.png" width="250"/></td>
</tr>
</div>
