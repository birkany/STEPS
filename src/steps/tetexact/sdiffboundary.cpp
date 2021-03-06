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
 
// Standard library & STL headers.
#include <vector>

// STEPS headers.
#include "steps/common.h"
#include "steps/solver/sdiffboundarydef.hpp"
#include "steps/tetexact/sdiffboundary.hpp"
#include "steps/tetexact/patch.hpp"

////////////////////////////////////////////////////////////////////////////////

namespace stex = steps::tetexact;
namespace ssolver = steps::solver;

////////////////////////////////////////////////////////////////////////////////

stex::SDiffBoundary::SDiffBoundary(steps::solver::SDiffBoundarydef * sdbdef)
: pSDiffBoundarydef(sdbdef)
, pSetPatches(false)
, pPatchA(0)
, pPatchB(0)
, pTris()
, pTriDirection()
{
    assert(sdbdef != 0);
}

////////////////////////////////////////////////////////////////////////////////

stex::SDiffBoundary::~SDiffBoundary(void)
{

}

////////////////////////////////////////////////////////////////////////////////

void stex::SDiffBoundary::checkpoint(std::fstream & cp_file)
{
    // reserve
}

////////////////////////////////////////////////////////////////////////////////

void stex::SDiffBoundary::restore(std::fstream & cp_file)
{
    // reserve
}

////////////////////////////////////////////////////////////////////////////////

void stex::SDiffBoundary::setPatches(stex::Patch * patcha, stex::Patch * patchb)
{
    assert (pSetPatches == false);
    assert(patcha != 0);
    assert(patchb != 0);
    assert(patcha != patchb);

    pPatchA = patcha;
    pPatchB = patchb;
    pSetPatches = true;
}

////////////////////////////////////////////////////////////////////////////////

stex::Patch * stex::SDiffBoundary::patchA(void)
{
    assert(pSetPatches == true);
    return pPatchA;
}

////////////////////////////////////////////////////////////////////////////////

stex::Patch * stex::SDiffBoundary::patchB(void)
{
    assert(pSetPatches == true);
    return pPatchB;
}

////////////////////////////////////////////////////////////////////////////////

void stex::SDiffBoundary::setTriDirection(uint tri, uint direction)
{
    assert(direction < 3);

    pTris.push_back(tri);
    pTriDirection.push_back(direction);
}

////////////////////////////////////////////////////////////////////////////////

// END

