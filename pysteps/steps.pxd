# -*- coding: utf-8 -*-
# =====================================================================================================================
# These bindings were automatically generated by cyWrap. Please do dot modify.
# Additional functionality shall be implemented in sub-classes.
#
__copyright__ = "Copyright 2016 EPFL BBP-project"
# =====================================================================================================================
from cython.operator cimport dereference as deref
cimport std


# ======================================================================================================================
cdef extern from "steps/init.hpp" namespace "steps":
# ----------------------------------------------------------------------------------------------------------------------
    ###### Static funcs ######
    void init()


# ======================================================================================================================
cdef extern from "steps/finish.hpp" namespace "steps":
# ----------------------------------------------------------------------------------------------------------------------
    ###### Static funcs ######
    void finish()


# ======================================================================================================================
cdef extern from "steps/error.hpp" namespace "steps":
# ----------------------------------------------------------------------------------------------------------------------

    ###### Cybinding for Err ######
    cdef cppclass Err(std.runtime_error):
        Err(std.string)
        char* getMsg()
        char* what()

    ###### Cybinding for NotImplErr ######
    cdef cppclass NotImplErr(Err):
        NotImplErr(std.string)

    ###### Cybinding for ArgErr ######
    cdef cppclass ArgErr(Err):
        ArgErr(std.string)

    ###### Cybinding for ProgErr ######
    cdef cppclass ProgErr(Err):
        ProgErr(std.string)

    ###### Cybinding for SysErr ######
    cdef cppclass SysErr(Err):
        SysErr(std.string)

    ###### Cybinding for IOErr ######
    cdef cppclass IOErr(Err):
        IOErr(std.string)
