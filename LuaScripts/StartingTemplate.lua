-- Starting template --
-- Use this script as a strarting point for new behaviours
-- Contains various useful values that are common to most scripts

maxAgent = interpreter:getNumAgents()

zero = {x=0.0,
		y=0.0,
		z=0.0}
    

for i=0, 200, 1
do
	-- First group of agents
	agent = interpreter:getAgent()
	
	-- If agent count exceeds maximum number of active agents a segfalt occurs.
	-- Reset to zero to prevent this.
	if agent > maxAgent
	then
		agent = 0
	end

    position = interpreter:getAgentPosition(agent)

	goal = interpreter:getGoal()	
	goalVector = interpreter:subVectors(goal, position)
	
	center = interpreter:getCenter()
	centerVector = interpreter:subVectors(center, position)
	
	cohesion = interpreter:getCohesion(agent)
	alignment = interpreter:getAlignment(agent)
	
	velocity = interpreter:addVectors(goalVector,cohesion)
	
	-- Retrieve current point of predator movement cycle
	newAngle = interpreter:getPredatorAngle()
		
	-- ensure angle doesn't exceed 360.
	if newAngle > 360 then newAngle = 0
	end
	
	interpreter:setSingleAgentVelocity(agent, velocity)
	

    interpreter:setAgent(agent + 1)
	

end







