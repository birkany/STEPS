# -*- coding: utf-8 -*-
# =====================================================================================================================
# These bindings were automatically generated by cyWrap. Please do dot modify.
# Additional functionality shall be implemented in sub-classes.
#
__copyright__ = "Copyright 2016 EPFL BBP-project"
# =====================================================================================================================
from cython.operator cimport dereference as deref
cimport std
cimport steps_rng
cimport steps_wm
cimport steps_model

# ======================================================================================================================
cdef extern from "steps/wmrk4/wmrk4.hpp" namespace "steps::wmrk4":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef std.vector[double] dVec
    # ctypedef std.vector[double].iterator dVecI
    # ctypedef std.vector[unsigned int] uiVec
    # ctypedef std.vector[unsigned int].iterator uiVecI

    ###### Cybinding for Wmrk4 ######
    cdef cppclass Wmrk4:
        Wmrk4(steps_model.Model*, steps_wm.Geom*, steps_rng.RNG*)
        std.string getSolverName()
        std.string getSolverDesc()
        std.string getSolverAuthors()
        std.string getSolverEmail()
        void reset()
        void run(double)
        void advance(double)
        void step()
        void setDT(double)
        void setRk4DT(double)
        double getTime()
        void checkpoint(std.string)
        void restore(std.string)
        Wmrk4()