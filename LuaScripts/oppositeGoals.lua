-- Opposite goals

-- Script is designed to show how two groups of agents interact with each other when travelling to opposite goals.
-- Faster agents are more aggressive to therefore slower agents will be forced to adjust their velocity.

-- Also serves to demonstrate the effects of cohesion on an agent's path.

maxAgent = interpreter:getNumAgents()

zero = {x=0.0,
		y=0.0,
		z=0.0}


firstGoal = {x=-100,
			 y=0,
			 z=-100}
    

for i=0, 400, 1
do
	-- First group of agents
	agent = interpreter:getAgent()
	
	-- If agent count exceeds maximum number of active agents a segfalt occurs.
	-- Reset to zero to prevent this.
	if agent > maxAgent
	then
		agent = 0
	end
	
	interpreter:setAgentMaxSpeed(agent, 2.0)

    position = interpreter:getAgentPosition(agent)
				 
	goalVector = interpreter:subVectors(firstGoal, position)
	
	cohesion = interpreter:getCohesion(agent)
	
	velocity = interpreter:addVectors(goalVector,cohesion)
	
	interpreter:setSingleAgentVelocity(agent, velocity)
	
	if position.x <  firstGoal.x
	then
		startPoint = {x=100+math.random(),y=0,z=100}

		interpreter:setAgentPosition(agent, startPoint)
	end
	
	
	--Second group
	agent = agent+1
	
	if agent > maxAgent
	then
		agent = 0
	end
	
	interpreter:setAgentMaxSpeed(agent, 0.5)
	
    position = interpreter:getAgentPosition(agent)
				 
	secondGoal = {x=100,
				 y=0,
				 z=-100}
				 
	goalVector = interpreter:subVectors(secondGoal, position)
	
	cohesion = interpreter:getCohesion(agent)
	
	velocity = interpreter:addVectors(goalVector,cohesion)
	
	interpreter:setSingleAgentVelocity(agent, velocity)
	
	if position.x >  secondGoal.x
	then
		startPoint = {x=-100-math.random(),y=0,z=100}

		interpreter:setAgentPosition(agent, startPoint)
	end
				 
				 

    interpreter:setAgent(agent + 1)
	

end







