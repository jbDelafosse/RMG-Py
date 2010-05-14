################################################################################
#
#	RMG - Reaction Mechanism Generator
#
#	Copyright (c) 2002-2009 Prof. William H. Green (whgreen@mit.edu) and the
#	RMG Team (rmg_dev@mit.edu)
#
#	Permission is hereby granted, free of charge, to any person obtaining a
#	copy of this software and associated documentation files (the 'Software'),
#	to deal in the Software without restriction, including without limitation
#	the rights to use, copy, modify, merge, publish, distribute, sublicense,
#	and/or sell copies of the Software, and to permit persons to whom the
#	Software is furnished to do so, subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be included in
#	all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#	DEALINGS IN THE SOFTWARE.
#
################################################################################

cdef extern from "dictobject.h":
	ctypedef class __builtin__.dict [object PyDictObject]:
		pass

cdef extern from "math.h":
	cdef double log(double theta)

################################################################################

cdef class ThermoModel:
	
	cdef public str comment
	cdef public double Tmin
	cdef public double Tmax
	
	cpdef bint isTemperatureValid(ThermoModel self, double T) except -2

################################################################################

cdef class ThermoGAModel(ThermoModel):

	cdef public double H298, S298
	cdef public list Cp
	cdef public str index
	
	# can't cpdef special methods like __add__ :-(
	#cpdef ThermoGAModel __add__(ThermoGAModel self, ThermoGAModel other)
	
	cpdef double getHeatCapacity(ThermoGAModel self, double T)
	
	cpdef double getEnthalpy(ThermoGAModel self, double T)

################################################################################

cdef class WilhoitModel(ThermoModel):

	cdef public double cp0
	cdef public double cpInf
	cdef public double B
	cdef public double a0
	cdef public double a1
	cdef public double a2
	cdef public double a3
	cdef public double H0
	cdef public double S0

	cpdef double getHeatCapacity(WilhoitModel self, double T)

	cpdef double getEnthalpy(WilhoitModel self, double T)

	cpdef double getEntropy(WilhoitModel self, double T)

	cpdef double getFreeEnergy(WilhoitModel self, double T)

	cpdef double integral_T0(WilhoitModel self, double t)

	cpdef double integral_TM1(WilhoitModel self, double t)

	cpdef double integral_T1(WilhoitModel self, double t)

	cpdef double integral_T2(WilhoitModel self, double t)

	cpdef double integral_T3(WilhoitModel self, double t)

	cpdef double integral_T4(WilhoitModel self, double t)

	cpdef double integral2_T0(WilhoitModel self, double t)

	cpdef double integral2_TM1(WilhoitModel self, double t)

################################################################################

cdef class NASAPolynomial(ThermoModel):
	
	cdef public double c0, c1, c2, c3, c4, c5, c6
	
	cpdef double getHeatCapacity(NASAPolynomial self, double T)
	
	cpdef double getEnthalpy(NASAPolynomial self, double T)
	
	cpdef double getEntropy(NASAPolynomial self, double T)
	
	cpdef double getFreeEnergy(NASAPolynomial self, double T)
	
	cpdef double integral2_T0(NASAPolynomial self, double t)
	
	cpdef double integral2_TM1(NASAPolynomial self, double t)
	

################################################################################
