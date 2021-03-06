########################################################################

# Well-mixed chemical reactions. 

# AIMS: to verify STEPS well-mixed stochastic solver 'Wmdirect' computes 
# reaction rates correctly when many different chemical species and 
# reactions are present in the model. 

# This model combines all well-mixed validations, as described at: 
# http://www.biomedcentral.com/content/supplementary/1752-0509-6-36-s4.pdf
# and in the equivalent individual model scripts.

########################################################################
 
import steps.model as smod
import steps.geom as sgeom
import steps.rng as srng
import steps.solver as ssolv

import numpy
import math
import time

from tol_funcs import *

########################################################################

def setup_module():
    global ran_sim

    ran_sim = False

def run_sim():
    # Set up and run the simulations once, before the tests
    # analyze the results.

    ##################### First order irreversible #########################

    global KCST_foi, N_foi, tolerance_foi

    KCST_foi = 5              # The reaction constant
    N_foi = 50                # Can set count or conc

    NITER_foi = 100000        # The number of iterations

    # Tolerance for the comparison:
    # In test runs, with good code, < 1%  will fail with a 1.5% tolerance
    tolerance_foi = 2.0/100  

    ####################### First order reversible #########################

    global KCST_f_for, KCST_b_for, COUNT_for, tolerance_for

    KCST_f_for = 10.0         # The reaction constant
    KCST_b_for = 2.0

    COUNT_for = 100000        # Can set count or conc

    NITER_for = 10            # The number of iterations

    # In test runs, with good code, <0.1% will fail with a tolerance of 1% 
    tolerance_for = 1.0/100

    ####################### Second order irreversible AA ###################

    global KCST_soAA, CONCA_soAA, CONCB_soAA, tolerance_soAA

    KCST_soAA = 50.0e6        # The reaction constant

    CONCA_soAA = 20.0e-6
    CONCB_soAA = CONCA_soAA

    NITER_soAA = 1000         # The number of iterations

    # In test runs, with good code, <0.1% will fail with a tolerance of 1% 
    tolerance_soAA = 1.0/100

    ####################### Second order irreversible AB ###################

    global KCST_soAB, CONCA_soAB, CONCB_soAB, tolerance_soAB

    KCST_soAB = 5.0e6         # The reaction constant

    CONCA_soAB = 1.0e-6
    n_soAB = 2
    CONCB_soAB = CONCA_soAB/n_soAB

    NITER_soAB = 1000         # The number of iterations


    # In test runs, with good code, <0.1% will fail with a tolerance of 1% 
    tolerance_soAB = 1.0/100

    ####################### Second order irreversible 2D ###################

    global COUNTA_so2d, COUNTB_so2d, CCST_so2d, tolerance_so2d

    COUNTA_so2d = 100.0
    n_so2d=2.0
    COUNTB_so2d = COUNTA_so2d/n_so2d 

    KCST_so2d = 10.0e10       # The reaction constant

    AREA_so2d = 10.0e-12

    CCST_so2d = KCST_so2d/(6.02214179e23*AREA_so2d)


    NITER_so2d = 1000         # The number of iterations

    # In tests fewer than 0.1% fail with tolerance of 2%
    tolerance_so2d = 2.0/100

    ############################ Common parameters ########################

    global VOL

    DT = 0.1                  # Sampling time-step
    INT = 1.1                 # Sim endtime
    VOL = 9.0e-18

    NITER_max = 100000

    ########################################################################

    mdl  = smod.Model()
    volsys = smod.Volsys('vsys',mdl)
    surfsys = smod.Surfsys('ssys',mdl)

    # First order irreversible
    A_foi = smod.Spec('A_foi', mdl)
    R1_foi = smod.Reac('R1_foi', volsys, lhs = [A_foi], rhs = [], kcst = KCST_foi)

    # First order reversible
    A_for = smod.Spec('A_for', mdl)
    B_for = smod.Spec('B_for', mdl)
    R1_for = smod.Reac('R1_for', volsys, lhs = [A_for], rhs = [B_for], kcst = KCST_f_for)
    R2_for = smod.Reac('R2_for', volsys, lhs = [B_for], rhs = [A_for], kcst = KCST_b_for)

    # Second order irreversible AA
    A_soAA = smod.Spec('A_soAA', mdl)
    B_soAA = smod.Spec('B_soAA', mdl)
    C_soAA = smod.Spec('C_soAA', mdl)
    R1_soAA = smod.Reac('R1_soAA', volsys, lhs = [A_soAA, B_soAA], rhs = [C_soAA], kcst = KCST_soAA)

    # Second order irreversible AB
    A_soAB = smod.Spec('A_soAB', mdl)
    B_soAB = smod.Spec('B_soAB', mdl)
    C_soAB = smod.Spec('C_soAB', mdl)
    R1_soAB = smod.Reac('R1_soAB', volsys, lhs = [A_soAB, B_soAB], rhs = [C_soAB], kcst = KCST_soAB)

    # Second order irreversible 2D
    A_so2d = smod.Spec('A_so2d', mdl)
    B_so2d = smod.Spec('B_so2d', mdl)
    C_so2d = smod.Spec('C_so2d', mdl)
    SR1_so2d = smod.SReac('SR1_so2d', surfsys, slhs = [A_so2d, B_so2d], srhs = [C_so2d], kcst = KCST_so2d)


    geom = sgeom.Geom()
    comp1 = sgeom.Comp('comp1', geom, VOL)
    comp1.addVolsys('vsys')
    patch1 = sgeom.Patch('patch1', geom, comp1, area = AREA_so2d)
    patch1.addSurfsys('ssys')


    rng = srng.create('r123', 512)
    rng.initialize(1000)


    sim = ssolv.Wmdirect(mdl, geom, rng)
    sim.reset()


    global tpnts, ntpnts
    tpnts = numpy.arange(0.0, INT, DT)
    ntpnts = tpnts.shape[0]


    res_m_foi = numpy.zeros([NITER_foi, ntpnts, 1])
    res_std1_foi = numpy.zeros([ntpnts, 1])
    res_std2_foi = numpy.zeros([ntpnts, 1])

    res_m_for = numpy.zeros([NITER_for, ntpnts, 2]) 

    res_m_soAA = numpy.zeros([NITER_soAA, ntpnts, 3])

    res_m_soAB = numpy.zeros([NITER_soAB, ntpnts, 3])

    res_m_so2d = numpy.zeros([NITER_so2d, ntpnts, 3])


    for i in range (0, NITER_max):
        sim.reset()
            
        if i < NITER_foi: 
            sim.setCompCount('comp1', 'A_foi', N_foi)
        
        if i < NITER_for: 
            sim.setCompCount('comp1', 'A_for', COUNT_for)
            sim.setCompCount('comp1', 'B_for', 0.0)
        
        if i < NITER_soAA:
            sim.setCompConc('comp1', 'A_soAA', CONCA_soAA)
            sim.setCompConc('comp1', 'B_soAA', CONCB_soAA)
        
        if i < NITER_soAB:
            sim.setCompConc('comp1', 'A_soAB', CONCA_soAB)
            sim.setCompConc('comp1', 'B_soAB', CONCB_soAB)
        
        if i < NITER_so2d:
            sim.setPatchCount('patch1', 'A_so2d', COUNTA_so2d)
            sim.setPatchCount('patch1', 'B_so2d', COUNTB_so2d)

        
        for t in range(0, ntpnts):
            sim.run(tpnts[t])
        
            if i < NITER_foi: 
                res_m_foi[i, t, 0] = sim.getCompCount('comp1', 'A_foi')
            
            if i < NITER_for: 
                res_m_for[i, t, 0] = sim.getCompConc('comp1', 'A_for')*1e6
                res_m_for[i, t, 1] = sim.getCompConc('comp1', 'B_for')*1e6
            
            if i < NITER_soAA:
                res_m_soAA[i, t, 0] = sim.getCompConc('comp1', 'A_soAA')
                res_m_soAA[i, t, 1] = sim.getCompConc('comp1', 'B_soAA')
            
            if i < NITER_soAB:
                res_m_soAB[i, t, 0] = sim.getCompConc('comp1', 'A_soAB')
                res_m_soAB[i, t, 1] = sim.getCompConc('comp1', 'B_soAB')

            if i < NITER_so2d:
                res_m_so2d[i, t, 0] = sim.getPatchCount('patch1', 'A_so2d')
                res_m_so2d[i, t, 1] = sim.getPatchCount('patch1', 'B_so2d') 


    global mean_res_foi, std_res_foi
    mean_res_foi = numpy.mean(res_m_foi, 0)
    std_res_foi = numpy.std(res_m_foi, 0)

    global mean_res_for
    mean_res_for = numpy.mean(res_m_for, 0)

    global mean_res_soAA
    mean_res_soAA = numpy.mean(res_m_soAA, 0)

    global mean_res_soAB
    mean_res_soAB = numpy.mean(res_m_soAB, 0)

    global mean_res_so2d
    mean_res_so2d = numpy.mean(res_m_so2d, 0)

    global ran_sim
    ran_sim = True

# Tests follow:

##################### First order irreversible #########################

def test_foi():
    "Reaction - First order, irreversible (Wmdirect)"

    if not ran_sim:
        run_sim()

    m_tol = 0
    for i in range(ntpnts):
        if i == 0: continue
        analy = N_foi*math.exp(-KCST_foi*tpnts[i])
        std = math.pow((N_foi*(math.exp(-KCST_foi*tpnts[i]))*(1-(math.exp(-KCST_foi*tpnts[i])))), 0.5)
        assert tolerable(analy, mean_res_foi[i], tolerance_foi)
        assert tolerable(std, std_res_foi[i], tolerance_foi)

####################### First order reversible #########################

def test_for():
    "Reaction - First order, reversible (Wmdirect)"

    if not ran_sim:
        run_sim()

    Aeq = COUNT_for*(KCST_b_for/KCST_f_for)/(1+(KCST_b_for/KCST_f_for))/(VOL*6.0221415e26)*1e6
    Beq = (COUNT_for/(VOL*6.0221415e26))*1e6 -Aeq
    for i in range(ntpnts):
        if i < 7: continue
        assert tolerable(mean_res_for[i,0], Aeq, tolerance_for)
        assert tolerable(mean_res_for[i,1], Beq, tolerance_for)

####################### Second order irreversible AA ###################

def test_soAA():
    "Reaction - Second order, irreversible, A0=B0 (Wmdirect)"

    if not ran_sim:
        run_sim()

    invA = numpy.zeros(ntpnts)
    invB = numpy.zeros(ntpnts)
    lineA  = numpy.zeros(ntpnts)
    lineB = numpy.zeros(ntpnts)
    for i in range(ntpnts):
        invA[i] = (1.0/mean_res_soAA[i][0])
        invB[i] = (1.0/mean_res_soAA[i][1])
        lineA[i] = (1.0/CONCA_soAA +((tpnts[i]*KCST_soAA)))
        lineB[i] = (1.0/CONCB_soAA + ((tpnts[i]*KCST_soAA)))
        
        assert tolerable(invA[i], lineA[i], tolerance_soAA)
        assert tolerable(invB[i], lineB[i], tolerance_soAA)

####################### Second order irreversible AB ###################

def test_soAB():
    "Reaction - Second order, irreversible, A0!=B0 (Wmdirect)"

    if not ran_sim:
        run_sim()

    lnBA_soAB = numpy.zeros(ntpnts)
    lineAB_soAB = numpy.zeros(ntpnts)
    C_soAB = CONCA_soAB-CONCB_soAB
    for i in range(ntpnts):
        A_soAB = mean_res_soAB[i][0]
        B_soAB = mean_res_soAB[i][1]
        lnBA_soAB[i] = math.log(B_soAB/A_soAB)
        lineAB_soAB[i] = math.log(CONCB_soAB/CONCA_soAB) -C_soAB*KCST_soAB*tpnts[i]
        
        assert tolerable(lnBA_soAB[i], lineAB_soAB[i], tolerance_soAB)

########################################################################

def test_so2d():
    "Reaction - Second-order, irreversible, 2D (Wmdirect)"

    if not ran_sim:
        run_sim()

    lnBA_so2d = numpy.zeros(ntpnts)
    lineAB_so2d = numpy.zeros(ntpnts)

    C_so2d = COUNTA_so2d-COUNTB_so2d

    for i in range(ntpnts):
        A_so2d = mean_res_so2d[i][0]
        B_so2d = mean_res_so2d[i][1]
        lnBA_so2d[i] = math.log(B_so2d/A_so2d)
        lineAB_so2d[i] = math.log(COUNTB_so2d/COUNTA_so2d) -C_so2d*CCST_so2d*tpnts[i]
        assert tolerable(lnBA_so2d[i], lineAB_so2d[i], tolerance_so2d)

########################################################################

