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

// Standard headers.
#include <cassert>
#include <algorithm>
#include <unordered_set>
#include <vector>
#include <sstream>
#include <string>

// STEPS headers.
#include "steps/common.h"
#include "steps/geom/sdiffboundary.hpp"
#include "steps/geom/tmpatch.hpp"
#include "steps/util/collections.hpp"
#include "steps/error.hpp"

namespace stetmesh = steps::tetmesh;

////////////////////////////////////////////////////////////////////////////////

stetmesh::SDiffBoundary::SDiffBoundary(std::string const & id, Tetmesh * container,
            std::vector<uint> const & bars, std::vector<stetmesh::TmPatch *> const & patches)
: pID(id)
, pTetmesh(container)
, pIPatch(nullptr)
, pOPatch(nullptr)
, pBarsN(0)
, pBar_indices()
{
    if (pTetmesh == 0)
        throw steps::ArgErr("No mesh provided to Surface Diffusion Boundary initializer function.");

    if (bars.empty())
    	throw steps::ArgErr("No triangles provided to Surface Diffusion Boundary initializer function.");

    if (patches.size() != 2)
        throw steps::ArgErr("The number of patches provided to Surface Diffusion initializer function must be length 2.");

    // The maximum triangle index in tetrahedral mesh
    uint maxidx = (pTetmesh->countBars() -1);

    std::unordered_set<uint> visited_bars(bars.size());
    for (uint bar: bars) {
        if (visited_bars.count(bar)) continue;
        visited_bars.insert(bar);

        if (bar > maxidx)
            throw steps::ArgErr("Invalid bar index "+std::to_string(bar)+".");

        if (pTetmesh->getBarSDiffBoundary(bar) != nullptr)
            throw steps::ArgErr("Bar with index "+std::to_string(bar)+" already belongs to a surface diffusion boundary.");

        // Need to find one triangle from inner patch and one from outer in this lot:
        std::set<uint> bartris = pTetmesh->getBarTriNeighbs(bar);

    	// Must be one and only one copy of inner patch and outer patch
    	int innertriidx = -1;
    	int outertriidx = -1;

        for (std::set<uint>::const_iterator tri = bartris.begin(); tri!=bartris.end(); ++tri )
        {
        	stetmesh::TmPatch *tri_patch = pTetmesh->getTriPatch(*tri);

        	if (tri_patch == patches[0])
        	{
        		if (innertriidx == -1) innertriidx = *tri;
        		else throw steps::ArgErr("Duplicate copy of patch" + patches[0]->getID() + " in connected triangles to bar " + std::to_string(bar));
        	}
        	else if (tri_patch == patches[1])
        	{
        		if (outertriidx == -1) outertriidx = *tri;
        		else throw steps::ArgErr("Duplicate copy of patch" + patches[1]->getID() + " in connected triangles to bar " + std::to_string(bar));
        	}
        }

        if (innertriidx == -1) throw steps::ArgErr("Patch" + patches[0]->getID() + " is not connected to bar " + std::to_string(bar));
        if (outertriidx == -1) throw steps::ArgErr("Patch" + patches[1]->getID() + " is not connected to bar " + std::to_string(bar));

        pBar_indices.push_back(bar);
        pTetmesh->setBarSDiffBoundary(bar, this);

        pTetmesh->setBarTris(bar, innertriidx, outertriidx);


    } // end of loop over all tris (argument to constructor)

    // Tests passed, last thing to do is record these patches
    pIPatch = patches[0];
    pOPatch = patches[1];

    pBarsN = pBar_indices.size();
    pTetmesh->_handleSDiffBoundaryAdd(this);

}

////////////////////////////////////////////////////////////////////////////////

void stetmesh::SDiffBoundary::setID(std::string const & id)
{
    assert(pTetmesh != 0);
    if (id == pID) return;
    // The following might raise an exception, e.g. if the new ID is not
    // valid or not unique. If this happens, we don't catch but simply let
    // it pass by into the Python layer.
    pTetmesh->_handleSDiffBoundaryIDChange(pID, id);
    // This line will only be executed if the previous call didn't raise
    // an exception.
    pID = id;
}

////////////////////////////////////////////////////////////////////////////////

std::vector<bool> stetmesh::SDiffBoundary::isBarInside(const std::vector<uint> & bars) const
{
    return steps::util::map_membership(bars, pBar_indices);
}

////////////////////////////////////////////////////////////////////////////////


// END
