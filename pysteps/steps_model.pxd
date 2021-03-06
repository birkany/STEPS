# -*- coding: utf-8 -*-
# =====================================================================================================================
# These bindings were automatically generated by cyWrap. Please do dot modify.
# Additional functionality shall be implemented in sub-classes.
#
__copyright__ = "Copyright 2016 EPFL BBP-project"
# =====================================================================================================================
from cython.operator cimport dereference as deref
cimport std
from libcpp cimport bool

# ======================================================================================================================
cdef extern from "steps/model/volsys.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Volsys* VolsysP
    # ctypedef std.map[std.string, Volsys*] VolsysPMap
    # ctypedef std.map[std.string, Volsys*].iterator VolsysPMapI
    # ctypedef std.map[std.string, Volsys*].const_iterator VolsysPMapCI

    ###### Cybinding for Volsys ######
    cdef cppclass Volsys:
        Volsys(std.string, Model*)
        std.string getID()
        void setID(const std.string &) except +
        Model* getModel()
        Reac* getReac(std.string) except +
        void delReac(std.string)
        std.vector[Reac*] getAllReacs()
        Diff* getDiff(std.string) except +
        void delDiff(std.string)
        std.vector[Diff*] getAllDiffs()
        std.vector[Spec*] getAllSpecs()


# ======================================================================================================================
cdef extern from "steps/model/chanstate.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef ChanState* ChanStateP
    # ctypedef std.map[std.string,ChanState*] ChanStatePMap
    # ctypedef std.map[std.string,ChanState*].iterator ChanStatePMapI
    # ctypedef std.map[std.string,ChanState*].const_iterator ChanStatePMapCI
    # ctypedef std.vector[ChanState*] ChanStatePVec
    # ctypedef std.vector[ChanState*].iterator ChanStatePVecI
    # ctypedef std.vector[ChanState*].const_iterator ChanStatePVecCI

    ###### Cybinding for ChanState ######
    cdef cppclass ChanState:
        ChanState(std.string, Model*, Chan*)
        Chan* getChan()
        void setID(std.string)

# ======================================================================================================================
cdef extern from "steps/model/ghkcurr.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef GHKcurr* GHKcurrP
    # ctypedef std.map[std.string,GHKcurr*] GHKcurrPMap
    # ctypedef std.map[std.string,GHKcurr*].iterator GHKcurrPMapI
    # ctypedef std.map[std.string,GHKcurr*].const_iterator GHKcurrPMapCI
    # ctypedef std.vector[GHKcurr*] GHKcurrPVec
    # ctypedef std.vector[GHKcurr*].iterator GHKcurrPVecI
    # ctypedef std.vector[GHKcurr*].const_iterator GHKcurrPVecCI
    # ctypedef std.map[std.string,double] MyMap

    ###### Cybinding for GHKcurr ######
    cdef cppclass GHKcurr:
        GHKcurr(std.string, Surfsys*, ChanState*, Spec*, bool, double, double)
        std.string getID()
        void setID(std.string)
        Surfsys* getSurfsys()
        Model* getModel()
        ChanState* getChanState()
        void setChanState(ChanState*)
        Spec* getIon()
        void setIon(Spec*)
        void setPInfo(double, double, double, double, double)
        void setP(double)


# ======================================================================================================================
cdef extern from "steps/model/diff.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Diff* DiffP
    # ctypedef std.map[std.string,Diff*] DiffPMap
    # ctypedef std.map[std.string,Diff*].iterator DiffPMapI
    # ctypedef std.map[std.string,Diff*].const_iterator DiffPMapCI
    # ctypedef std.vector[Diff*] DiffPVec
    # ctypedef std.vector[Diff*].iterator DiffPVecI
    # ctypedef std.vector[Diff*].const_iterator DiffPVecCI

    ###### Cybinding for Diff ######
    cdef cppclass Diff:
        Diff(std.string, Volsys*, Spec*, double)
        Diff(std.string, Surfsys*, Spec*, double)
        std.string getID()
        void setID(std.string)
        Volsys* getVolsys()
        Surfsys* getSurfsys()
        Model* getModel()
        Spec* getLig()
        void setLig(Spec*)
        double getDcst()
        void setDcst(double)
        std.vector[Spec*] getAllSpecs()


# ======================================================================================================================
cdef extern from "steps/model/vdeptrans.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef VDepTrans* VDepTransP
    # ctypedef std.map[std.string,VDepTrans*] VDepTransPMap
    # ctypedef std.map[std.string,VDepTrans*].iterator VDepTransPMapI
    # ctypedef std.map[std.string,VDepTrans*].const_iterator VDepTransPMapCI
    # ctypedef std.vector[VDepTrans*] VDepTransPVec
    # ctypedef std.vector[VDepTrans*].iterator VDepTransPVecI
    # ctypedef std.vector[VDepTrans*].const_iterator VDepTransPVecCI

    ###### Cybinding for VDepTrans ######
    cdef cppclass VDepTrans:
        VDepTrans(std.string, Surfsys*, ChanState*, ChanState*, std.vector[double], double, double, double, unsigned int)
        std.string getID()
        void setID(std.string)
        Surfsys* getSurfsys()
        Model* getModel()
        Chan* getChan()
        ChanState* getSrc()
        void setSrc(ChanState*)
        ChanState* getDst()
        void setDst(ChanState*)
        std.vector[double] getRate()

# ======================================================================================================================
cdef extern from "steps/model/vdepsreac.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef VDepSReac* VDepSReacP
    # ctypedef std.map[std.string,VDepSReac*] VDepSReacPMap
    # ctypedef std.map[std.string,VDepSReac*].iterator VDepSReacPMapI
    # ctypedef std.map[std.string,VDepSReac*].const_iterator VDepSReacPMapCI
    # ctypedef std.vector[VDepSReac*] VDepSReacPVec
    # ctypedef std.vector[VDepSReac*].iterator VDepSReacPVecI
    # ctypedef std.vector[VDepSReac*].const_iterator VDepSReacPVecCI

    ###### Cybinding for VDepSReac ######
    cdef cppclass VDepSReac:
        VDepSReac(std.string, Surfsys*, std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[double], double, double, double, unsigned int)
        std.string getID()
        void setID(std.string)
        Surfsys* getSurfsys()
        Model* getModel()
        bool getInner()
        bool getOuter()
        std.vector[Spec*] getOLHS()
        void setOLHS(std.vector[Spec*])
        std.vector[Spec*] getILHS()
        void setILHS(std.vector[Spec*])
        std.vector[Spec*] getSLHS()
        void setSLHS(std.vector[Spec*])
        std.vector[Spec*] getIRHS()
        void setIRHS(std.vector[Spec*])
        std.vector[Spec*] getSRHS()
        void setSRHS(std.vector[Spec*])
        std.vector[Spec*] getORHS()
        void setORHS(std.vector[Spec*])
        unsigned int getOrder()
        std.vector[double] getK()
        std.vector[Spec*] getAllSpecs()

# ======================================================================================================================
cdef extern from "steps/model/reac.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Reac* ReacP
    # ctypedef std.map[std.string,Reac*] ReacPMap
    # ctypedef std.map[std.string,Reac*].iterator ReacPMapI
    # ctypedef std.map[std.string,Reac*].const_iterator ReacPMapCI
    # ctypedef std.vector[Reac*] ReacPVec
    # ctypedef std.vector[Reac*].iterator ReacPVecI
    # ctypedef std.vector[Reac*].const_iterator ReacPVecCI

    ###### Cybinding for Reac ######
    cdef cppclass Reac:
        Reac(std.string, Volsys*, std.vector[Spec*], std.vector[Spec*], double)
        std.string getID()
        void setID(std.string)
        Volsys* getVolsys()
        Model* getModel()
        std.vector[Spec*] getLHS()
        void setLHS(std.vector[Spec*])
        std.vector[Spec*] getRHS()
        void setRHS(std.vector[Spec*])
        std.vector[Spec*] getAllSpecs()
        unsigned int getOrder()
        double getKcst()
        void setKcst(double)
        


# ======================================================================================================================
cdef extern from "steps/model/sreac.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef SReac* SReacP
    # ctypedef std.map[std.string,SReac*] SReacPMap
    # ctypedef std.map[std.string,SReac*].iterator SReacPMapI
    # ctypedef std.map[std.string,SReac*].const_iterator SReacPMapCI
    # ctypedef std.vector[SReac*] SReacPVec
    # ctypedef std.vector[SReac*].iterator SReacPVecI
    # ctypedef std.vector[SReac*].const_iterator SReacPVecCI

    ###### Cybinding for SReac ######
    cdef cppclass SReac:
        SReac(std.string, Surfsys*, std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], std.vector[Spec*], double)
        std.string getID()
        void setID(std.string)
        Surfsys* getSurfsys()
        Model* getModel()
        bool getInner()
        bool getOuter()
        std.vector[Spec*] getOLHS()
        void setOLHS(std.vector[Spec*])
        std.vector[Spec*] getILHS()
        void setILHS(std.vector[Spec*])
        std.vector[Spec*] getSLHS()
        void setSLHS(std.vector[Spec*])
        std.vector[Spec*] getIRHS()
        void setIRHS(std.vector[Spec*])
        std.vector[Spec*] getSRHS()
        void setSRHS(std.vector[Spec*])
        std.vector[Spec*] getORHS()
        void setORHS(std.vector[Spec*])
        unsigned int getOrder()
        double getKcst()
        void setKcst(double)
        std.vector[Spec*] getAllSpecs()

# ======================================================================================================================
cdef extern from "steps/model/chan.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Chan* ChanP
    # ctypedef std.map[std.string,Chan*] ChanPMap
    # ctypedef std.map[std.string,Chan*].iterator ChanPMapI
    # ctypedef std.map[std.string,Chan*].const_iterator ChanPMapCI
    # ctypedef std.vector[Chan*] ChanPVec
    # ctypedef std.vector[Chan*].iterator ChanPVecI
    # ctypedef std.vector[Chan*].const_iterator ChanPVecCI

    ###### Cybinding for Chan ######
    cdef cppclass Chan:
        Chan(std.string, Model*)
        std.string getID()
        void setID(std.string)
        Model* getModel()
        ChanState* getChanState(std.string)
        std.vector[ChanState*] getAllChanStates()

# ======================================================================================================================
cdef extern from "steps/model/ohmiccurr.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef OhmicCurr* OhmicCurrP
    # ctypedef std.map[std.string,OhmicCurr*] OhmicCurrPMap
    # ctypedef std.map[std.string,OhmicCurr*].iterator OhmicCurrPMapI
    # ctypedef std.map[std.string,OhmicCurr*].const_iterator OhmicCurrPMapCI
    # ctypedef std.vector[OhmicCurr*] OhmicCurrPVec
    # ctypedef std.vector[OhmicCurr*].iterator OhmicCurrPVecI
    # ctypedef std.vector[OhmicCurr*].const_iterator OhmicCurrPVecCI

    ###### Cybinding for OhmicCurr ######
    cdef cppclass OhmicCurr:
        OhmicCurr(std.string, Surfsys*, ChanState*, double, double)
        std.string getID()
        void setID(std.string)
        Surfsys* getSurfsys()
        Model* getModel()
        ChanState* getChanState()
        void setChanState(ChanState*)
        double getERev()
        void setERev(double)
        double getG()
        void setG(double)

# ======================================================================================================================
cdef extern from "steps/model/spec.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Spec* SpecP
    # ctypedef std.map[std.string,Spec*] SpecPMap
    # ctypedef std.map[std.string,Spec*].iterator SpecPMapI
    # ctypedef std.map[std.string,Spec*].const_iterator SpecPMapCI
    # ctypedef std.vector[Spec*] SpecPVec
    # ctypedef std.vector[Spec*].iterator SpecPVecI
    # ctypedef std.vector[Spec*].const_iterator SpecPVecCI

    ###### Cybinding for Spec ######
    cdef cppclass Spec:
        Spec(std.string, Model*, int)
        std.string getID()
        void setID(std.string)
        Model* getModel()
        void setValence(int)
        int getValence()



# ======================================================================================================================
cdef extern from "steps/model/surfsys.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Surfsys* SurfsysP
    # ctypedef std.map[std.string, Surfsys*] SurfsysPMap
    # ctypedef std.map[std.string, Surfsys*].iterator SurfsysPMapI
    # ctypedef std.map[std.string, Surfsys*].const_iterator SurfsysPMapCI

    ###### Cybinding for Surfsys ######
    cdef cppclass Surfsys:
        Surfsys(std.string, Model*)
        std.string getID()
        void setID(std.string)
        Model* getModel()
        SReac* getSReac(std.string) except +
        void delSReac(std.string)
        std.vector[SReac*] getAllSReacs()
        Diff* getDiff(std.string) except +
        void delDiff(std.string)
        std.vector[Diff*] getAllDiffs()
        VDepTrans* getVDepTrans(std.string) except +
        void delVDepTrans(std.string)
        std.vector[VDepTrans*] getAllVDepTrans()
        VDepSReac* getVDepSReac(std.string) except +
        void delVDepSReac(std.string)
        std.vector[VDepSReac*] getAllVDepSReacs()
        OhmicCurr* getOhmicCurr(std.string) except +
        void delOhmicCurr(std.string)
        std.vector[OhmicCurr*] getAllOhmicCurrs()
        GHKcurr* getGHKcurr(std.string) except +
        void delGHKcurr(std.string)
        std.vector[GHKcurr*] getAllGHKcurrs()
        std.vector[Spec*] getAllSpecs()




# ======================================================================================================================
cdef extern from "steps/model/model.hpp" namespace "steps::model":
# ----------------------------------------------------------------------------------------------------------------------
    # ctypedef Spec* SpecP
    # ctypedef std.vector[Spec*] SpecPVec
    # ctypedef std.vector[Spec*].iterator SpecPVecI
    # ctypedef std.vector[Spec*].const_iterator SpecPVecCI
    # ctypedef Volsys* VolsysP
    # ctypedef std.vector[Volsys*] VolsysPVec
    # ctypedef std.vector[Volsys*].iterator VolsysPVecI
    # ctypedef std.vector[Volsys*].const_iterator VolsysPVecCI
    # ctypedef Surfsys* SurfsysP
    # ctypedef std.vector[Surfsys*] SurfsysPVec
    # ctypedef std.vector[Surfsys*].iterator SurfsysPVecI
    # ctypedef std.vector[Surfsys*].const_iterator SurfsysPVecCI
    # ctypedef Chan* ChanP
    # ctypedef std.vector[Chan*] ChanPVec
    # ctypedef std.vector[Chan*].iterator ChanPVecI
    # ctypedef std.vector[Chan*].const_iterator ChanPVecCI
    # ctypedef std.map[std.string,Volsys*] VolsysPMap
    # ctypedef std.map[std.string,Volsys*].iterator VolsysPMapI
    # ctypedef std.map[std.string,Volsys*].const_iterator VolsysPMapCI
    # ctypedef std.map[std.string,Surfsys*] SurfsysPMap
    # ctypedef std.map[std.string,Surfsys*].iterator SurfsysPMapI
    # ctypedef std.map[std.string,Surfsys*].const_iterator SurfsysPMapCI

    ###### Cybinding for Model ######
    cdef cppclass Model:
        Model()
        Spec* getSpec(std.string) except +
        void delSpec(std.string) except +
        std.vector[Spec*] getAllSpecs()
        Chan* getChan(std.string)
        std.vector[Chan*] getAllChans()
        Volsys* getVolsys(std.string) except +
        void delVolsys(std.string) except +
        std.vector[Volsys*] getAllVolsyss()
        Surfsys* getSurfsys(std.string) except +
        void delSurfsys(std.string) except +
        std.vector[Surfsys*] getAllSurfsyss()

