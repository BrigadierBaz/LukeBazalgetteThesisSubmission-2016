-- Feeding simulation --

-- Fish will swarm around predators until moving on to next point.

-- Gobal variables

-- Total number of agents for loop condition
maxAgent = interpreter:getNumAgents()

-- Vector3 format
zero = {x=0.0,
		y=0.0,
		z=0.0}

-- Retrieve current point of predator movement cycle
newAngle = interpreter:getPredatorAngle()

-- Interate on angle for staggered animation
interpreter:setPredatorAngle(newAngle+1.0)

-- ensure angle doesn't exceed 360.
if newAngle == 360 then newAngle = 0
end

-- convert angle into radians
predatorAngle = math.rad(newAngle)
    

-- Change second value to increase Velocity sample rate
for i=0, 200, 1
do
	-- Get the current agent
	agent = interpreter:getAgent()
	
	-- If agent count exceeds maximum number of active agents a segfalt occurs.
	-- Reset to zero to prevent this.
	if agent > maxAgent
	then
		agent = 0
	end
	
	-- Get Vector data for current agent
	velocity = interpreter:getAgentVelocity(agent)
    position = interpreter:getAgentPosition(agent)
	
	-- Get the middle of the agent swarm
    center = interpreter:getCenterOfSwarm()
    
    -- Get position of goal in simulation
    goal = interpreter:getGoal()
    goalVector = interpreter:subVectors(goal, position)

	-- return the value to Cpp for use in functions		  
    interpreter:setCenter(center)
    
    -- Get the distance from agent to center of swarm
    centerVector = interpreter:subVectors(center, position)

	-- Initial position of predator
    predator = {x= 100,y=0,z=0}

    otherPredator = {x= 250,y=0,z=0}

    finalPredator = {x= 500,y=0,z=0}
					

    -- You can set any given Vector as a predator
    predatorArray = { predator, otherPredator, finalPredator}
    
	-- Get absolute values of Vectors
    positionAbsolute = interpreter:getAbsoluteValue(position)
    predatorAbsolute = interpreter:getAbsoluteValue(predator)
    centerAbsolute = interpreter:getAbsoluteValue(center)
    

    -- Angle of velocity adjustment agents undergo
    angle = math.rad(math.pi * 45)
    
    
    
	-- Distance agents detect predators
    distance = 70
    
    -- Previous predator to be detected
    -- required in order for agents to respond to multiple predaotrs.
    oldPredator = {x=0,y=0,z=0}
	
	-- Number of predators in the range of the bait ball				
	predatorsInRange = 0
	
	objective = {x=600,y=0,z=0}
	
	objectiveVector = interpreter:subVectors(objective,position)
	
	-- Set agent to bait ball before searching for predators.
	-- This will maintain bait ball shape.
	interpreter:setSingleAgentVelocity(agent, objectiveVector)

	-- Loop through list of predators and adjust velocity of each agents
	for k,v in pairs(predatorArray)
	do
	-- Get current predator and absolute position
	newPredator = predatorArray[k]
	predatorAbsolute = interpreter:getAbsoluteValue(newPredator)
		
		-- Check if predator is in range of the bait ball
		if newPredator["x"] - distance < position["x"] and position["x"] < newPredator["x"] + distance and
		   newPredator["z"] - distance < position["z"] and position["z"] < newPredator["z"] + distance and
		   newPredator["y"] - distance < position["y"] and position["y"] < newPredator["y"] + distance
		 then
		 
		 if predatorAbsolute - 20 < positionAbsolute and
			predatorAbsolute + 20 > positionAbsolute
			then
		 
			-- Add to value if a predator is within range. Used to scale magnitude.
			predatorsInRange = predatorsInRange + 1
			
			-- Update center vector
			centerVector = interpreter:addVectors(center, position)
			

			-- Update the velocity of the agent
			oldVelocity = interpreter:getAgentVelocity(agent)
			
			-- Check that there is a recorded value in OldPredator
			if oldPredator.x ~= 0
			then
				oldVelocity = interpreter:subVectors(position,oldPredator)
			end
			
			
			-- Scale vector according to how many predators are in range
			newPredator = interpreter:divideVectors(newPredator,predatorsInRange)
			
			predatorVector = interpreter:subVectors(newPredator, position)
			
			oldVelocity = interpreter:addVectors(oldVelocity, predatorVector)
			
			oldVelocity = interpreter:divideVectors(oldVelocity,2)
			
			-- Agent moves away from predator
			interpreter:setSingleAgentVelocity(agent, oldVelocity)
			
			-- Set position of current vector to be used in next looop if needed
			oldPredator = interpreter:addVectors(oldPredator, v)
			oldPredator = interpreter:divideVectors(interpreter:addVectors(oldPredator, v),predatorsInRange)
			
			end
		end
	end
    
    -- Iterate agent count and return to Cpp
    interpreter:setAgent(agent + 1)

end

numPredators = interpreter:getPredators()

-- Pass positions of predators back into program
if numPredators == 0 then
for k,v in pairs(predatorArray)
do
	interpreter:setPredators(v)
end
end








