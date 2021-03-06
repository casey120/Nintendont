/*
CheckTestMenuGP.S for Nintendont (Kernel)

Copyright (C) 2016 FIX94

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation version 2.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
#include <asm.h>

.set IN_TESTMENU,	0xD3003080 #uncached for kernel

#r3 gets overwritten later

CheckTestMenuGP:
	#original instruction
	clrlwi	%r0,	%r26,	24

	lis		%r26,	IN_TESTMENU@h
	cmpwi	%r0,	0
	bne		DoCheck
	b		end		#No Test Menu, just exit
DoCheck:	#Test Menu requested, make sure it wasnt loaded
	lwz		%r0,	IN_TESTMENU@l(%r26)
	cmpwi	%r0,	0
	bne		Disallow
Allow:	#Not loaded previously, enter test menu
	li		%r0,	1
	b		end
Disallow:	#Test Menu previously loaded so disallow
	li		%r0,	0
end:	#Always save current status for next time
	stw		%r0,	IN_TESTMENU@l(%r26)
	blr
