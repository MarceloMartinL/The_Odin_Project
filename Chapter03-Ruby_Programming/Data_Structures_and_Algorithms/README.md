# Data Structures and Algorithms

## Searching Binary Trees

You learned about tree search algorithms like breadth-first-search and depth-first-search. You learned that BFS is best used to find the optimum solution but can take a very long time (impractically long for broad and deep data sets) while DFS is often much faster but will give you the FIRST solution, not necessarily the best. Here you’ll get a chance to implement both.

You’ll build a simple binary tree data structure from some arbitrary input and also the “crawler” function that will locate data inside of it.

1. Build a class Node. It should have a value that it stores and also links to its parent and children (if they exist). Build getters and setters for it (e.g. parent node, child node(s)).

2. Write a method build_tree which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a binary tree full of Node objects appropriately placed. Start by assuming the array you get is sorted.

3. Now refactor your build_tree to handle data that isn’t presorted and cannot be easily sorted prior to building the tree. You’ll need to figure out how to add a node for each of the possible cases (e.g. if it’s a leaf versus in the middle somewhere).

4. Write a simple script that runs build_tree so you can test it out.

5. Build a method breadth_first_search which takes a target value and returns the node at which it is located using the breadth first search technique. Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to search and to add new ones to the list (as you saw in the video). If the target node value is not located, return nil.

6. Build a method depth_first_search which returns the node at which the target value is located using the depth first search technique. Use an array acting as a stack to do this.

7. Next, build a new method dfs_rec which runs a depth first search as before but this time, instead of using a stack, make this method recursive.

Tips:

1. You can think of the `dfs_rec` method as a little robot that crawls down the tree, checking if a node is the correct node and spawning other little robots to keep searching the tree.  No robot is allowed to turn on, though, until all the robots to its left have finished their task.

2. The method will need to take in both the target value and the current node to compare against.

## Knight’s Travails (My Favorite)

Now you’re a pro with DFS and BFS. Let’s try using our search algorithms on a real problem. For this project, you’ll need to use a data structure that’s similar (but not identical) to a binary tree.

A knight in chess can move to any square on the standard 8x8 chess board from any other square on the board, given enough turns (don’t believe it? [See this animation](https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Knight%27s_tour_anim_2.gif/250px-Knight%27s_tour_anim_2.gif)). Its basic move is two steps forward and one step to the side. It can face any direction.

All the possible places you can end up after one move look like this:

![index](https://i.imgur.com/mHQqH08.gif)

Your task is to build a function knight_moves that shows the simplest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

You can think of the board as having 2-dimensional coordinates. Your function would therefore look like:

```ruby
knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]
```

1. Put together a script that creates a game board and a knight.

2. Treat all possible moves the knight could make as children in a tree. Don’t allow any moves to go off the board.

3. Decide which search algorithm is best to use for this case. Hint: one of them could be a potentially infinite series.

4. Use the chosen search algorithm to find the shortest path between the starting square (or node) and the ending square. Output what that full path looks like, e.g.:

```
> knight_moves([3,3],[4,3])
  => You made it in 3 moves!  Heres your path:
    [3,3]
    [4,5]
    [2,4]
    [4,3]
```

Project Source: https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms
