# next_tools
Select the next most likely tool in Sketchup using a Markov chain. 

## Installation instructions
1. Download the rbz file in next_tools/rbz
2. Install the sketchup extension using the following instructions: https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup
3. Add a hotkey for for the following commands using these instructions: https://help.sketchup.com/en/sketchup/customizing-your-keyboard-and-mouse#:~:text=Select%20Window%20%3E%20Preferences.,appears%20in%20the%20Assigned%20box  
    a. Extensions/Next Tool/Most Likely Next Tool.  
    b. Extensions/Next Tool/Clear Tool History. 
 
## How it works
Tool in action            |          Diagram
:-------------------------:|:-------------------------:
![Imgur Image](https://i.imgur.com/3KuZ426.gif)  |  ![Imgur Image](https://i.imgur.com/0zex3qM.png)

The plugin keeps track of state transitions from one tool to another and updates a transition matrix utilizing a markov chain. This allows the user to utilize only one hotkey to transition to multiple tools. 

## Why I made it

I was given a problem statement:
`Given array of states that transition to one another. Calculate the final probability of every terminal state. States can feed back into themselves.`

Assumptions I made:
1. The state space is finite.  
2. Transition probabilites between nodes are known

I graphed out what this looked like to me to get a better understanding and it looked something like this:
![Imgur Image](https://i.imgur.com/IpLhw6y.png)

The way that I interpreted the problem it seemed like it could be solved using Dijkstra's algorithm because it can handle negative weights, infinite loops, and terminal states that are inaccessible. 

I've never implemented this algorithm, and given only a few days to complete a goal task, I decided scale the problem down to a much smaller task.




    