#ifndef LUA_INTERPRETER_H
#define LUA_INTERPRETER_H

#include"lua.hpp"

#include <memory>
#include "RVO2-3D/RVO.h"

/// @file LuaInterpreter.h
/// @brief Defines member variables and functions to be used by Lua.
/// @author Luke Bazalgette, Alex Ames
/// @version 1.0
/// @date 08/04/16
/// @class LuaInterpreter
/// @brief Lua can only call static functions of type integer.
/// However it's possible for non-static function to be called within the static examples.
/// Values are passed from the static functions in LuaFunctions to this class.
/// It is also possible to return values back to LuaFunctions.
/// @author Luke Bazalgette
/// Derived from :-
/// Alex Ames (April 8 2013). LuaWrapperExample/example2 [online].
/// [Accessed 2016]. Available from: <https://bitbucket.org/alexames/luawrapperexample/src/f6958844b60f91ed90d039eabe807522a1b13ba8/example2/Example.hpp?at=default&fileviewer=file-view-default>.
/// @date 08/04/2016

class LuaInterpreter
{

  public:

      //LuaInterpreter(int agentNum);
      LuaInterpreter() : m_center(),
                         m_goal(),
                         m_agent(),
                         m_predators(),
                         m_predatorAngle(){}

      RVO::Vector3 m_center; //!< Stoare Vector value representing center of flock
      RVO::Vector3 m_goal = RVO::Vector3(0.0f,0.0f,0.0f);//!< Position of goal point in the simulation
      int m_agent;//!< Agent Number stored in the sim
      std::vector <RVO::Vector3> m_predators;//!< Vector array containing the positions of predators active in the sim.
      float m_predatorAngle;//!< Angle of predator movement stored in the simulation

      float m_agentSpeed;//!< Stores maximum speed of the agent to be retrieved by the simulation.
      float m_numAgents;//!< Stores maximum number of agents to be retrieved by the simulation.

      RVO::Vector3 getAgentVelocity(int agentNum) const;
      RVO::Vector3 getAgentPosition(int agentNum) const;


      int getAgentNeighborNum(int agentNum, int neighborCount) const;
      int getAgentNeighborCount(int agentNum) const;
      void setPredators(RVO::Vector3 predator);


      float getPredatorAngle() const;
      void setPredatorAngle(float angle);



      float getAgentMaxSpeed(int agentNum);
      void  setAgentMaxSpeed(int agentNum, float newSpeed);



      float getAbsoluteValue (RVO::Vector3 input) const;
      float getPowerOf(float input, float power) const;



      const RVO::Vector3& getPosition() const;
      void setPosition(const RVO::Vector3& Member);



      const RVO::Vector3& getGoal() const;
      void setGoal(const RVO::Vector3& Member);
//      RVO::Vector3 getGoalVector(int agentNum) const;



      const RVO::Vector3& getCenter() const;
      void setCenter(const RVO::Vector3& Member);
//      RVO::Vector3 getCenterVector(int agentNum) const;



      RVO::Vector3 getCohesion(int agentNum) const;
      RVO::Vector3 getAlignment(int agentNum) const;
//      RVO::Vector3 get

      RVO::Vector3 getCenterOfSwarm() const;


      //int getNumAgents() const;

      void setSingleAgentVelocity(int agentNum, RVO::Vector3 targetVector);
      void setAgentPosition(int agentNum, RVO::Vector3 targetVector);
      void setAllAgentVelocities(RVO::Vector3 target, RVO::Vector3 inputVelocity);

      RVO::Vector3 addVectors(RVO::Vector3 firstVector, RVO::Vector3 secondVector);
      RVO::Vector3 subVectors(RVO::Vector3 firstVector, RVO::Vector3 secondVector);
      RVO::Vector3 multiplyVectors(RVO::Vector3 firstVector, float value);
      RVO::Vector3 divideVectors(RVO::Vector3 firstVector, float value);
      bool compareVectors(RVO::Vector3 firstVector, RVO::Vector3 secondVector);

      // Clean up functions below when necessary.

      //kaguya::State m_luaTest;
      lua_State* L = luaL_newstate();//!< Pointer to active LuaState

      std::unique_ptr<RVO::RVOSimulator> m_sim;//!< Pointer to active RVO Simulation

};


#endif // LUA_INTERPRETER_H

