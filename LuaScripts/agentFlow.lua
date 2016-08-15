-- Agent Flow --
--Demonstrates how the constant flow of agents can be changed over time
maxAgent = interpreter:getNumAgents()

zero = {x=0.0,
		y=0.0,
		z=0.0}
		
-- Retrieve current point of predator movement cycle
newAngle = interpreter:getPredatorAngle()
	
-- ensure angle doesn't exceed 360.
if newAngle > 100 then newAngle = 0
end

	-- Interate on angle for staggered animation
interpreter:setPredatorAngle(newAngle+0.001)
    

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

    position = interpreter:getAgentPosition(agent)
    positionAbsolute = interpreter:getAbsoluteValue(position)

	firstGoal = {x=-100,
				 y=0,
				 z=-100}
				 
	goalVector = interpreter:subVectors(firstGoal, position)
	
	cohesion = interpreter:getCohesion(agent)
	
	velocity = interpreter:addVectors(goalVector,cohesion)

	
	amp = 100.0

	-- Determin the curve that the velocity is modified by	
	curveX=(amp*math.cos(newAngle*2))
	curveY=(amp*math.sin(newAngle*2))

	-- Cohesion provides steering effect
	velocity.x = curveX + cohesion.x
	velocity.y = curveY + cohesion.y
	
	interpreter:setSingleAgentVelocity(agent, velocity)
	
	-- Reset the positions of the agents
	if position.z <  firstGoal.z + 10
	then
		startPoint = {x=-100-math.random(),y=0,z=100}

		interpreter:setAgentPosition(agent, startPoint)
	end
	

    interpreter:setAgent(agent + 1)
	

end







