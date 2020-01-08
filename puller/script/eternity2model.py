#!/usr/bin/python
# -*- coding: utf-8 -*-

#
#  Eternity II Job Puller
#
#  Copyright © 2019 Yohan Firmy
#

import configparser

class SolverResult:
  def __init__(self, result, resultDate):
    self.board = result
    self.date = resultDate

class SolverInfo:
  def __init__(self, config, solver):
      self.name = config.get('Solver', 'name')
      self.version = "1.7.6"
      self.machineType = config.get('Solver', 'machine.type')
      self.clusterName = config.get('Solver', 'cluster.name')
      self.capacity, self.score = solver.check_solver_capacity()
