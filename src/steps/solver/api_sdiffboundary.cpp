/*
 #################################################################################
#
#    STEPS - STochastic Engine for Pathway Simulation
#    Copyright (C) 2007-2017 Okinawa Institute of Science and Technology, Japan.
#    Copyright (C) 2003-2006 University of Antwerp, Belgium.
#    
#    See the file AUTHORS for details.
#    This file is part of STEPS.
#    
#    STEPS is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License version 2,
#    as published by the Free Software Foundation.
#    
#    STEPS is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#    
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#################################################################################   

 */


// STL headers.
#include <string>
#include <sstream>

// STEPS headers.
#include "steps/common.h"
#include "steps/error.hpp"
#include "steps/solver/api.hpp"
#include "steps/solver/statedef.hpp"

////////////////////////////////////////////////////////////////////////////////

USING(std, string);
using namespace steps::solver;

////////////////////////////////////////////////////////////////////////////////

void API::setSDiffBoundaryDiffusionActive(string const & sdb, string const & s, bool act)
{
    uint sdbidx = pStatedef->getSDiffBoundaryIdx(sdb);
    uint sidx = pStatedef->getSpecIdx(s);

    return _setSDiffBoundaryDiffusionActive(sdbidx, sidx, act);
}

////////////////////////////////////////////////////////////////////////////////

bool API::getSDiffBoundaryDiffusionActive(string const & sdb, string const & s) const
{
    uint sdbidx = pStatedef->getSDiffBoundaryIdx(sdb);
    uint sidx = pStatedef->getSpecIdx(s);

    return _getSDiffBoundaryDiffusionActive(sdbidx, sidx);
}

////////////////////////////////////////////////////////////////////////////////

void API::setSDiffBoundaryDcst(std::string const & sdb, std::string const & s, double dcst, std::string const & direction_patch)
{
    uint sdbidx = pStatedef->getSDiffBoundaryIdx(sdb);
    uint sidx = pStatedef->getSpecIdx(s);
    if (direction_patch.empty()) {
        _setSDiffBoundaryDcst(sdbidx, sidx, dcst);
    }
    else {
        uint pidx = pStatedef->getPatchIdx(direction_patch);
        _setSDiffBoundaryDcst(sdbidx, sidx, dcst, pidx);
    }
}

////////////////////////////////////////////////////////////////////////////////

void API::_setSDiffBoundaryDiffusionActive(uint sdbidx, uint sidx, bool act)
{
    throw steps::NotImplErr();
}

////////////////////////////////////////////////////////////////////////////////

bool API::_getSDiffBoundaryDiffusionActive(uint sdbidx, uint sidx) const
{
    throw steps::NotImplErr();
}

////////////////////////////////////////////////////////////////////////////////

void API::_setSDiffBoundaryDcst(uint sdbidx, uint sidx, double dcst, uint direction_patch)
{
    throw steps::NotImplErr();
}

////////////////////////////////////////////////////////////////////////////////

// END
