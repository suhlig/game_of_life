# Game of Life in Ruby

This is a modified clone of Rob Cole's [robcole/game_of_life](https://github.com/robcole/game_of_life)) implementation.

## Getting Started

* Make sure you have a recent (~2.x) Ruby
* Clone the repo
* Change into the directory and install the dependencies:

  ```bash
  gem install bundler
  bundle install
  ```

* Start the test loop with `bundle exec guard`

# Design Notes

The following are extracts from Rob Cole's documentation.

## The Rules

> 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
> 2. Any live cell with two or three live neighbours lives on to the next generation.
> 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
> 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

> ... here are the steps our program will be walking through:

> 1. The grid finds all live coordinates.
> 2. The grid adds 1 point to the score of each of the coordinates surrounding a live coordinate.
> 3. The grid creates a new living cell for all new living cells, and kills all cells which should be killed.

## Implementation Notes

> We'll be breaking the Game of Life down into two separate classes - Grids and Cells. Cells will be responsible for knowing their coordinates and their state (alive or dead). Grids will be able to find the nearest neighbors of a cell given a position, to create a new grid with a new pattern, and to calculate the next state for a given cell given its neighbors. Finally, a grid will also be able to call `grid#draw` in order to display itself.

## Using Patterns to Create Grids

> ... to play around with the grid later, it'll be much easier for us to be able to "draw" a pattern and then pass that.

> To get to that point, we're going to refactor our Grid#initialize method to be able to handle patterns as well as coordinates. We'll be using the "-" character to note dead cells and "X" to note live cells, so we can write code like this:

```
pattern = %q(----X----
      			 ----X----
      			 ----X----
      			 ---------
      			 XXX---XXX
      			 ---------
      			 ----X----
      			 ----X----
      			 ----X----).gsub(/[^\S\n]/m, '')

grid = Grid.new(pattern: pattern)
```

## Keeping Track of Cells: Knowing Your Neighbors

> Once we have a list of living coordinates, we can start moving on to keeping track of which cells need to be updated. To do this, we first need to find the neighbors of the current cell.

> If you think of the grid as a set of coordinates, your neighbors can be found based on applying an offset of [-1, 0, 1] to both the X and Y coordinates. For example, a coordinate of [4, 4] would have neighbors of: [3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5].

> We'll be storing these coordinates for each cell when a new cell is created, so the neighbors of a cell can easily accessed rather than computed each time.

> To calculate this when we create a new cell, we'll need to take the 8 offsets and add each of them to the cell's coordinates.

## Which Cells Need to be Changed?

> Once we have a list of live cells and their neighbors, the next step is to calculate the "score" for each cell. For each live cell, we will add 1 point to the score of each of it's neighbors; we will then use that score to determine which cells stay die, come to live, or stay the same.
