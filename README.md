# next_tools
Select the next most likely tool in Sketchup using a Markov chain. 

## Installation instructions
1. Download the rbz file in [next_tools/rbz](https://github.com/dukefromearth/next_tools/tree/master/rbz)  
2. [Install the next_tools.rbz sketchup extension.](https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup)
3. [Add hotkeys for the following actions:](https://help.sketchup.com/en/sketchup/customizing-your-keyboard-and-mouse#:~:text=Select%20Window%20%3E%20Preferences.,appears%20in%20the%20Assigned%20box)  
    a. Extensions/Next Tool/Most Likely Next Tool.  
    b. Extensions/Next Tool/Clear Tool History. 
 
## How it works
Tool in action            |    State Diagram
:-------------------------:|:-------------------------:
![Imgur Image](https://i.imgur.com/3KuZ426.gif)  |  ![Imgur Image](https://i.imgur.com/0NDjgVx.png)

The plugin keeps track of state transitions from one tool to another and updates a transition matrix utilizing a markov chain. This allows the user to utilize only one hotkey to transition to multiple tools.

### [Known Issues](https://github.com/dukefromearth/next_tools/issues)

## Why I made it

Inspired by this statement:
`Given array of states that transition to one another. Calculate the final probability of every terminal state. States can feed back into themselves.`

Assumptions I made:
1. The state space is finite.  
2. Transition probabilites between nodes are known

I graphed out what this looked like to me to get a better understanding and it looked something like this:
![Imgur Image](https://i.imgur.com/IpLhw6y.png)

The way that I interpreted the problem, it seemed like it could be solved using Dijkstra's algorithm, because it can handle negative weights, infinite loops, and terminal states that are inaccessible. 

<img src="https://i.imgur.com/PuuYMcc.gif" width=300></img>

I initially thought that I could model this by modifying plinko by randomly assigning friction, restitution, to the nodes and calculating the transition probabilites. Given only a few days to complete a goal task, I decided scale the problem down to a much smaller task.




    
