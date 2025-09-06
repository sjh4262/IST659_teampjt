
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

SELECT 1
FROM location_items li
JOIN locations l ON l.location_id=li.location_id
JOIN items i     ON i.item_id=li.item_id
WHERE l.location_name='Beacon Tower' AND i.item_name='Nav Beacon Core';


-- Load database game
USE starship_relaunch
GO
-- look around crash site
EXEC usp_lookaround @player_id = 1
GO


/**********************************************************************
  Explore East 
**********************************************************************/

-- Jeonghwan - Revision
DECLARE @nav_core_id INT = (SELECT item_id FROM items WHERE item_name='Nav Beacon Core');

EXEC usp_MovePlayer @player_id = 1, @direction = 'east';
-- EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Beacon Tower item
-- right direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'right';

-- pick up item

-- Original Code
-- EXEC usp_pickUpItem @player_id = 1, @item_id = 1

-- Jeonghwan - Revision
EXEC usp_pickUpItem @player_id=1, @item_id=@nav_core_id;

-- back to location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'west';

EXEC usp_showInventory @player_id=1;

/**********************************************************************
  Explore West 
**********************************************************************/

-- Jeonghwan - Revision
DECLARE @ecu_id INT = (SELECT item_id FROM items WHERE item_name='Electronics Control Unit');

EXEC usp_MovePlayer @player_id = 1, @direction = 'west';
-- EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'right';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Forest Item
-- left direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
-- pick up item
-- Original code
-- EXEC usp_pickUpItem @player_id = 1, @item_id = 2

-- Jeonghwan - Revision
EXEC usp_pickUpItem @player_id = 1, @item_id = @ecu_id;

-- back to west location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';
-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'east';

/**********************************************************************
  Explore North 
**********************************************************************/

-- Jeonghwan - Revision
DECLARE @fc_id INT = (SELECT item_id FROM items WHERE item_name='Fuel Cell');

EXEC usp_MovePlayer @player_id = 1, @direction = 'north';
-- EXEC usp_lookaround @player_id = 1

EXEC usp_MovePlayer @player_id = 1, @direction = 'forward';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

EXEC usp_MovePlayer @player_id = 1, @direction = 'left';
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- Dreary desert item
-- right direction
EXEC usp_MovePlayer @player_id = 1, @direction = 'right';

-- pick up item
-- Original code
-- EXEC usp_pickUpItem @player_id = 1, @item_id = 3

-- Jeonghwan - Revision
EXEC usp_pickUpItem @player_id = 1, @item_id = @fc_id

-- back to location
EXEC usp_MovePlayer @player_id = 1, @direction = 'back';

-- back to crash site
EXEC usp_MovePlayer @player_id = 1, @direction = 'south';


/**********************************************************************
  Explore South 
**********************************************************************/

-- Jeonghwan - Revision
-- Get the item_id for the Micro-generator dynamically by name
DECLARE @mg_id INT = (SELECT item_id FROM items WHERE item_name='Micro-generator');

-- Move the player south from the Crash Site into the South region (Alien Marshland)
EXEC usp_MovePlayer @player_id=1, @direction='south';

-- Move left from the South hub to reach the Foggy Mud Flat (where the item is placed)
EXEC usp_MovePlayer @player_id=1, @direction='left';

-- Pick up the Micro-generator using the looked-up ID
EXEC usp_pickUpItem @player_id=1, @item_id=@mg_id;

-- Move back from the Foggy Mud Flat to the South hub (Alien Marshland)
EXEC usp_MovePlayer @player_id=1, @direction='back';

-- Move north from the South  hub to return to the Crash Site
EXEC usp_MovePlayer @player_id=1, @direction='north';

-- Check if the player has collected all four required items and complete the game
EXEC usp_completeGame @player_id=1;
