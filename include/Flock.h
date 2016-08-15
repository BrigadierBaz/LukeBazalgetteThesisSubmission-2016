#ifndef FLOCK_H
#define FLOCK_H

#include "luawrapper.hpp"

#include <memory>
#include "RVO2-3D/RVO.h"
#include "LuaInterpreter.h"

/// @file Flock.h
/// @brief Defines members and functions of Flock.
/// @class Flock
/// @author Luke Bazalgette
/// @version 1.0
/// @date 08/08/16
/// @brief This class dictates the default status of the sim and the script to be loaded.


class Flock
{
public:
  Flock();

  /// the sim
  static std::unique_ptr <LuaInterpreter> m_lua; //!< Pointer to the LuaInterpreter
  std::vector <RVO::Vector3> m_goals;//!< Vector array containing goal positions
  std::string m_luaSimScript = "";//!< String to store filepath retrieved from file dialog

  bool m_animate=true;//!< Condition determining wheter to run simulation

  // Agent defaults
  double m_neighborDist = 15.0f;//!< Default maximum distance at which agent registers neighbors
  int m_numOfNeighbors = 15; //!< Default maximum number of neighbours which agent registers
  double m_agentRadius = 2.0f; //!< Default collision radius of agent

  void setupSim();
  void setPreferredVelocities();


};

#endif // FLOCK_H
