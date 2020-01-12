


########### TYPE CONVERSIONS ##########

C types							From Python types			To Python types
-------							-----------------			---------------
char, short, int, long			int, long					int
int, long, long long			int, long					long
float, double, long double		int, long, float			float
char*							str 						str
struct, union					dict						dict

"""
cdef struct:

* A struct is just a collection of variables, sort of like a named tuple, 
except the memory is contiguous.

* Structs cant have methods, only attributes.
"""

cdef struct Grail:
	int age
	float volume

"""
cdef union

* Um this is like two possible different values for the same variable????

"""

cdef union Food:
	char *spam
	float *eggs



############ DEBUGGING ##########

# outputs an html file of the generated C code where 
# each line has a different shaed of yellow and 
# more yellow means more Python interactions = slower
cython -a file.pyx

