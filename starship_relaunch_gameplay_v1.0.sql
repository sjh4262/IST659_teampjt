
/**********************************************************************
  IST-657: Database Administration and Concepts
  Final Project (Summer 2025) - Team 1
  Gameplay Script
  Jeong Hwan Son, Darrell Collison, Tristan Morlock, Robert Nitto
  Date: 2025-09-01
**********************************************************************/

/**********************************************************************
  Starship Relaunch v1.0
**********************************************************************/

-- Game Overview:
-- The game map consists of 5 connected locations:
--                        North
--                          |
--             West - [Crash Site] - East
--                          |
--                        South
--
-- Key Concepts:
-- 1. n linked tables
-- 2. fact vs. lookup
-- 3. Stored procedures are used to "play" the game

/**********************************************************************
  GAMEPLAY 
**********************************************************************/
-- Player starts at the Crash Site and must explore each of the 4 areas

-- Load database game
USE starship_relaunch
GO
-- look around crash site
EXEC usp_lookaround @player_id = 1
GO

/**********************************************************************
  Explore East 
**********************************************************************/

EXEC usp_MovePlayer @player_id = 1, @direction = 'east';
EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Beacon Tower item
-- right direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'right';

-- pick up item
EXEC usp_pickUpItem @player_id = 1, @item_id = 1

-- back to location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'west';

/**********************************************************************
  Explore West 
**********************************************************************/

EXEC usp_MovePlayer @player_id = 1, @direction = 'west';
EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'right';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Forest Item
-- left direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
-- pick up item
EXEC usp_pickUpItem @player_id = 1, @item_id = 2
-- back to west location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';
-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'east';

/**********************************************************************
  Explore North 
**********************************************************************/

EXEC usp_MovePlayer @player_id = 1, @direction = 'north';
EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Dreary desert item
-- right direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'right';

-- pick up item
EXEC usp_pickUpItem @player_id = 1, @item_id = 3

-- back to location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'south';


/**********************************************************************
  Explore South 
**********************************************************************/