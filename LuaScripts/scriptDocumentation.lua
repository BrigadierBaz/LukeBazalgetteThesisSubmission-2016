-- Luke Bazalgette Thesis Lua Syntax Guide --

-- WARNING
-- This code is not intended to be run within the simulation
-- It is meerely to document a list of valid syntax

-- The functions listed in this docuyment should be safe to cut and paste into a valid Lua script.

--1. Interpreter variables

	-- luawrapper already provides functionality for multiple variable types
	-- Integers, floats and strings are straightforward to return
	
	agentNum = 0
	float = 0.0
	stringSample = "Hello word!"

	-- RVO::Vector3
	-- These are written as tables within Lua.
	-- Please follow the format below

	vector = {x=0,y=0,z=0}

	-- Contents of X,Y and Z are float values
	-- Returned as RVO::Vector3
	-- please remember to include X,Y and Z, otherwise it will be treated as a regular table.

	-- Values of the Vector can be accessed in Lua as such

	vector.x = vector.y
	
--2. Interpreter functions

	--Full list of valid interpreter functions and arguments
	-- The following functions are Getters and Setters for variables sotred within Cpp.
	-- This is neccessary as Lua flushes all variable values on completing script execution.
	
	agentNum = interpreter:getAgent() --Get agent value stored in LuaInterpreter Cpp class
	interpreter:setAgent(interger) --Set the agent value to an integer from Lua
	
	goal = interpreter:getGoal() --Get position of goal stored in LuaInterpreter Cpp class
	interpreter:setGoal(vector) --Set position of goal stored in LuaInterpreter Cpp class
	
	center = interpreter:getCenter() --Get vector value of center stored in LuaInterpreter Cpp class
	interpreter:setCenter(vector) --Get vector value of center stored in LuaInterpreter Cpp class
	
	predatorCount = interpreter:getPredators() --Get size of predator array. Returned as Integer.
	interpreter:setPredators(vector) --Push a Vector value into m_predators in Cpp. Used to draw predators in NGLScene. 
									 --Put in a loop to push multiple values in a table.
	
	predatorAngle = interpreter:getPredatorAngle() --Get the angle of predator movment from LuaInterpreter class.
								   --Since it is intended to iterate with each run of the script it is important to return the value.
	interpreter:setPredatorAngle(float) --Set value in Cpp. It is advised to be used as an iterator.
	
	-- The following functions retrieve values to be used as constraints within the script.
	agentCount = interpreter:getNumAgents() -- Get number of active agents in the simulation
	interpreter:getAgentNeighborCount(agentNum) --retrieve total number of neighbors for a given agent.
	
	--Without these, certain loops may cause a segmentation fault
	
	
	-- Reynolds behaviours
	-- These are global behaviours calculated in Cpp
	-- They are common to most flocking algorithms as such simplify the code required.
	cohesion = interpreter:cohesion(agentNum) --returns Vector velocity that achieves cohesion
	alignment = interpreter:alignment(agentNum) -- returns Vector velocity that achieves alignment
	
	-- Agent operations
	-- set agent attributes using these functions.
	velocity = interpreter:getAgentVelocity(agentNum) -- get the current velocity of a given agent
	position = interpreter:getAgentPosition(agentNum) -- get the current position of a given agent
	
	interpreter:setAgentPosition(agentNum, vector) -- set the position of an agent to a specified vector
	
	interpreter:setSingleAgentVelocity(agentNum, vector) -- set the preferred velocity of a given agent
	intepreter:setAllAgentVelocities(vector) -- Set a new preferred velocity for the entire swarm
	
	maxSpeed = interpreter:getAgentMaxSpeed(agentNum) -- Get the agent's current max speed.
	interpreter:setAgentMaxSpeed(agentNum, float) --Set agent max speed to a given float.
	
	flockCenter = interpreter:getCenterOfSwarm() --Get the average position of all agents in the simulation.
	
	-- Vector operations
	vector = interpreter:addvectors(vector,vector) --Adds the corresponding axis of each Vector to one another
	vector = interpreter:subVectors(vector,vector) --Subtract the right hand vector from the left and return the value
	
	vector = interpreter:multiplyVector(vector, 1) --Scale the vector values by the argument on the right.
	vector = interpreter:divideVector(vector, 1) -- divide the values in the given vector by the argument on the right.
	
	bool = compareVectors(vector,vector) --Find out if two vectors have the same values. returns 1 if true, otherwise 0.
										 --Useful as an If condition
										 
	absolute = interpreter:getAbsoluteValue(position) -- Returns absolute value (length) of a given vector. Returned as float.
	power = interpreter:getPowerOf(float,2) --Returns the power of a given float value to the right hand argument. Lua doesn't have this functionality.
	

-- 3. Useful code

-- This section is dedicated to pieces of useful code that is applicable to most scripts

	-- If you have an angle iterator you won't want it to exceed 360.
	-- This function resets the value to 0, place at the begginning of your code and before interacting the angle
	if newAngle == 360 
		then newAngle = 0 
	end
	
	-- Printing Vectors:
	-- To print a vector it must be placed within a loop like this.
	for k,v in pairs(vector)
	do
		print k,v
	end
	
	-- Vector to a point.
	-- If you want to make an agent travel to a given point...
	-- you will need to find the distance between it's current position and the goal.
	
	-- Get the distance from agent to center of swarm
    centerVector = interpreter:subVectors(center, position)
    interpreter:setSingleAgentVelocity(agentNum, centerVector)
	
	-- This applies to any given point
	
	-- This is a typical loop for applying new Velocities to all active agents
	
	for i=0, 50, 1 -- Set second value to decide how many agents to sample during a given loop
	do
		-- Get the current agent from LuaInterpreter
		agent = interpreter:getAgent()
		
		-- If agent count exceeds maximum number of active agents a segfalt occurs.
		-- Reset to zero to prevent this.
		if agent > maxAgent
		then
			agent = 0
		end
		
		-- Iterate agent number for next loop
		-- Also ensures that each agent is assessed in order
		interpreter:setAgent(agent + 1)

	end
	
	
	
	
	
	




