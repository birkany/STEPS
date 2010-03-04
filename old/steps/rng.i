////////////////////////////////////////////////////////////////////////////////
// STEPS - STochastic Engine for Pathway Simulation
// Copyright (C) 2007-2009 Okinawa Institute of Science and Technology, Japan.
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

%module rng

%import "cpp/steps/common.h"

%include "python/std_string.i"
%include "error.i"

%{
	// Autotools definitions.
#ifdef HAVE_CONFIG_H
#include <steps/config.h>
#endif
	
#include <steps/rng/rng.hpp>
%}


///////////////////////////////////////////////////////////////////////////////	

%exception 
{
	try {
		$action
	} catch (steps::ArgErr & ae) {
		PyErr_SetString(PyExc_NameError, ae.getMsg());
		return NULL;
	} catch (steps::NotImplErr & nie) {
		PyErr_SetString(PyExc_NotImplementedError, nie.getMsg());
		return NULL;
	}
}

///////////////////////////////////////////////////////////////////////////////	

namespace steps
{
	namespace rng
	{
		
		////////////////////////////////////////////////////////////////////////////////
		
		class RNG
		{
			
		public:
			
			RNG(unsigned int bufsize);
			virtual ~RNG(void);
			
			void initialize(unsigned long const & seed);
			
			unsigned int get(void);
			
			double getUnfII(void);
			double getUnfIE(void);
			double getUnfEE(void);
			double getUnfIE53(void);
			
			float getStdExp(void);
			virtual double getExp(double lambda);
			long getPsn(float lambda);
			float getStdNrm(void);
			
		protected:
			// Mark this class as abstract.
			virtual void concreteInitialize(ulong seed) = 0;
			virtual void concreteFillBuffer(void) = 0;
			
		};
		
		////////////////////////////////////////////////////////////////////////////////
		
		RNG * create_mt19937(unsigned int bufsize);
		
		RNG * create(std::string rng_name, unsigned int bufsize);
		
		////////////////////////////////////////////////////////////////////////////////
		
	} // end namespace rng
} // end namespace steps

// END
