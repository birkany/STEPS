////////////////////////////////////////////////////////////////////////////////
// STEPS - STochastic Engine for Pathway Simulation
// Copyright (C) 2007-2014 Okinawa Institute of Science and Technology, Japan.
// Copyright (C) 2003-2006 University of Antwerp, Belgium.
//
// See the file AUTHORS for details.
//
// This file is part of STEPS.
//
// STEPS is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// STEPS is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////

// Standard library & STL headers.
#include <vector>

// STEPS headers.
#include "steps/common.h"
#include "steps/solver/sdiffboundarydef.hpp"
#include "steps/mpi/tetopsplit/sdiffboundary.hpp"
#include "steps/mpi/tetopsplit/patch.hpp"

////////////////////////////////////////////////////////////////////////////////

namespace smtos = steps::mpi::tetopsplit;
namespace ssolver = steps::solver;

////////////////////////////////////////////////////////////////////////////////

smtos::SDiffBoundary::SDiffBoundary(steps::solver::SDiffBoundarydef * sdbdef)
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

smtos::SDiffBoundary::~SDiffBoundary(void)
{

}

////////////////////////////////////////////////////////////////////////////////

void smtos::SDiffBoundary::checkpoint(std::fstream & cp_file)
{
    // reserve
}

////////////////////////////////////////////////////////////////////////////////

void smtos::SDiffBoundary::restore(std::fstream & cp_file)
{
    // reserve
}

////////////////////////////////////////////////////////////////////////////////

void smtos::SDiffBoundary::setPatches(smtos::Patch * patcha, smtos::Patch * patchb)
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

smtos::Patch * smtos::SDiffBoundary::patchA(void)
{
    assert(pSetPatches == true);
    return pPatchA;
}

////////////////////////////////////////////////////////////////////////////////

smtos::Patch * smtos::SDiffBoundary::patchB(void)
{
    assert(pSetPatches == true);
    return pPatchB;
}

////////////////////////////////////////////////////////////////////////////////

void smtos::SDiffBoundary::setTriDirection(uint tri, uint direction)
{
    assert(direction < 3);

    pTris.push_back(tri);
    pTriDirection.push_back(direction);
}

////////////////////////////////////////////////////////////////////////////////

// END

