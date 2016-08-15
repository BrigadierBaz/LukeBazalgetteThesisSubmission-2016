-- Fish Tornado

-- Simulates a shoaling style exhibited by fish schools.
-- Resembles a vortex
maxAgent = interpreter:getNumAgents()

zero = {x=0.0,
		y=0.0,
		z=0.0}
    
-- Retrieve current point of predator movement cycle
newAngle = interpreter:getPredatorAngle()
	
-- ensure angle doesn't exceed 360.
if newAngle > 360 then newAngle = 0
end

interpreter:setPredatorAngle(newAngle+0.01)

-- convert angle into radians
predatorAngle = math.rad(newAngle)


firstGoal = {x=-100,y=0,z=-100}
	
-- Point predator orientates around
flowOrigin = {x= 60,y=0,z=10}

speed = 0.1
magintude = 100
-- Move in an irregular pattern
firstGoal["x"] = (flowOrigin["x"] + math.cos(newAngle*speed) * 100)
firstGoal["z"] = (flowOrigin["z"] + math.sin(newAngle*speed) * 100)


interpreter:setGoal(firstGoal)

for i=0, 20, 1
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
	
	cohesion = interpreter:getCohesion(agent)
	
	interpreter:setAgentMaxSpeed(agent, 0.5)

    
    				 
	goalVector = interpreter:subVectors(firstGoal, position)
    
    
    velocity = interpreter:addVectors(goalVector,cohesion)
    
    -- Fish occilate relative to their point of origin.
    -- Pattern is perturbed further through neighbour awareness
    curveY=(2.0*math.sin(newAngle*2*math.pi))
    
    -- Cohesion needs to be readded to the velocity to produce formation
    velocity.y = curveY + cohesion.y
	
	interpreter:setSingleAgentVelocity(agent, velocity)
	

    interpreter:setAgent(agent + 1)
	

end







