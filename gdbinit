set startup-with-shell off

# set to 1 to have ARM target debugging as default, use the "arm" command to switch inside gdb
set $ARM = 0
# set to 0 if you have problems with the colorized prompt - reported by Plouj with Ubuntu gdb 7.2
set $COLOREDPROMPT = 1
# color the first line of the disassembly - default is green, if you want to change it search for
# SETCOLOR1STLINE and modify it :-)
set $SETCOLOR1STLINE = 0
# set to 0 to remove display of objectivec messages (default is 1)
set $SHOWOBJECTIVEC = 1
# set to 0 to remove display of cpu registers (default is 1)
set $SHOWCPUREGISTERS = 1
# set to 1 to enable display of stack (default is 0)
set $SHOWSTACK = 0
# set to 1 to enable display of data window (default is 0)
set $SHOWDATAWIN = 0
# set to 0 to disable colored display of changed registers
set $SHOWREGCHANGES = 1
# set to 1 so skip command to execute the instruction at the new location
# by default it EIP/RIP will be modified and update the new context but not execute the instruction
set $SKIPEXECUTE = 0
# if $SKIPEXECUTE is 1 configure the type of execution
# 1 = use stepo (do not get into calls), 0 = use stepi (step into calls)
set $SKIPSTEP = 1
# show the ARM opcodes - change to 0 if you don't want such thing (in x/i command)
set $ARMOPCODES = 1
# x86 disassembly flavor: 0 for Intel, 1 for AT&T
set $X86FLAVOR = 0
# use colorized output or not
set $USECOLOR = 1
# to use with remote KDP
set $KDP64BITS = -1
set $64BITS = 0

set confirm off
set verbose off
set history filename ~/.gdb_history
set history save

set output-radix 0x10
set input-radix 0x10

# These make gdb never pause in its output
set height 0
set width 0

set $SHOW_CONTEXT = 1
set $SHOW_NEST_INSN = 0

set $CONTEXTSIZE_STACK = 6
set $CONTEXTSIZE_DATA  = 8
set $CONTEXTSIZE_CODE  = 8

# __________________end gdb options_________________
#

# __________________color functions_________________
#
# color codes
set $BLACK = 0
set $RED = 1
set $GREEN = 2
set $YELLOW = 3
set $BLUE = 4
set $MAGENTA = 5
set $CYAN = 6
set $WHITE = 7

# CHANGME: If you want to modify the "theme" change the colors here
#          or just create a ~/.gdbinit.local and set these variables there
set $COLOR_REGNAME = $GREEN
set $COLOR_REGVAL = $BLACK
set $COLOR_REGVAL_MODIFIED  = $RED
set $COLOR_SEPARATOR = $BLUE
set $COLOR_CPUFLAGS = $RED

# this is ugly but there's no else if available :-(
define color
 if $USECOLOR == 1
 	# BLACK
 	if $arg0 == 0
 		echo \033[30m
 	else
 		# RED
	 	if $arg0 == 1
	 		echo \033[31m
	 	else
	 		# GREEN
	 		if $arg0 == 2
	 			echo \033[32m
	 		else
	 			# YELLOW
	 			if $arg0 == 3
	 				echo \033[33m
	 			else
	 				# BLUE
	 				if $arg0 == 4
	 					echo \033[34m
	 				else
	 					# MAGENTA
	 					if $arg0 == 5
	 						echo \033[35m
	 					else
	 						# CYAN
	 						if $arg0 == 6
	 							echo \033[36m
	 						else
	 							# WHITE
	 							if $arg0 == 7
	 								echo \033[37m
	 							end
	 						end
	 					end
	 				end
	 			end
	 		end
	 	end
	 end
 end
end

define color_reset
    if $USECOLOR == 1
	   echo \033[0m
    end
end

define color_bold
    if $USECOLOR == 1
	   echo \033[1m
    end
end

define color_underline
    if $USECOLOR == 1
	   echo \033[4m
    end
end

# this way anyone can have their custom prompt - argp's idea :-)
# can also be used to redefine anything else in particular the colors aka theming
# just remap the color variables defined above
# source ~/.gdbinit.local

# can't use the color functions because we are using the set command
if $COLOREDPROMPT == 1
	set prompt \033[31mgdb$ \033[0m
end

# Initialize these variables else comparisons will fail for coloring
# we must initialize all of them at once, 32 and 64 bits, and ARM.
set $oldrax = 0
set $oldrbx = 0
set $oldrcx = 0
set $oldrdx = 0
set $oldrsi = 0
set $oldrdi = 0
set $oldrbp = 0
set $oldrsp = 0
set $oldr8  = 0
set $oldr9  = 0
set $oldr10 = 0
set $oldr11 = 0
set $oldr12 = 0
set $oldr13 = 0
set $oldr14 = 0
set $oldr15 = 0
set $oldeax = 0
set $oldebx = 0
set $oldecx = 0
set $oldedx = 0
set $oldesi = 0
set $oldedi = 0
set $oldebp = 0
set $oldesp = 0
set $oldr0  = 0
set $oldr1  = 0
set $oldr2  = 0
set $oldr3  = 0
set $oldr4  = 0
set $oldr5  = 0
set $oldr6  = 0
set $oldr7  = 0
set $oldsp  = 0
set $oldlr  = 0

# used by ptraceme/rptraceme
set $ptrace_bpnum = 0

# ______________window size control___________
define contextsize-stack
    if $argc != 1
        help contextsize-stack
    else
        set $CONTEXTSIZE_STACK = $arg0
    end
end
document contextsize-stack
Syntax: contextsize-stack NUM
| Set stack dump window size to NUM lines.
end


define contextsize-data
    if $argc != 1
        help contextsize-data
    else
        set $CONTEXTSIZE_DATA = $arg0
    end
end
document contextsize-data
Syntax: contextsize-data NUM
| Set data dump window size to NUM lines.
end


define contextsize-code
    if $argc != 1
        help contextsize-code
    else
        set $CONTEXTSIZE_CODE = $arg0
    end
end
document contextsize-code
Syntax: contextsize-code NUM
| Set code window size to NUM lines.
end


# _____________breakpoint aliases_____________
define bpl
    info breakpoints
end
document bpl
Syntax: bpl
| List all breakpoints.
end


define bp
    if $argc != 1
        help bp
    else
        break $arg0
    end
end
document bp
Syntax: bp LOCATION
| Set breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
| To break on a symbol you must enclose symbol name inside "".
| Example:
| bp "[NSControl stringValue]"
| Or else you can use directly the break command (break [NSControl stringValue])
end


define bpc 
    if $argc != 1
        help bpc
    else
        clear $arg0
    end
end
document bpc
Syntax: bpc LOCATION
| Clear breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bpe
    if $argc != 1
        help bpe
    else
        enable $arg0
    end
end
document bpe
Syntax: bpe NUM
| Enable breakpoint with number NUM.
end


define bpd
    if $argc != 1
        help bpd
    else
        disable $arg0
    end
end
document bpd
Syntax: bpd NUM
| Disable breakpoint with number NUM.
end


define bpt
    if $argc != 1
        help bpt
    else
        tbreak $arg0
    end
end
document bpt
Syntax: bpt LOCATION
| Set a temporary breakpoint.
| This breakpoint will be automatically deleted when hit!.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bpm
    if $argc != 1
        help bpm
    else
        awatch $arg0
    end
end
document bpm
Syntax: bpm EXPRESSION
| Set a read/write breakpoint on EXPRESSION, e.g. *address.
end


define bhb
    if $argc != 1
        help bhb
    else
        hb $arg0
    end
end
document bhb
Syntax: bhb LOCATION
| Set hardware assisted breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bht
    if $argc != 1
        help bht
    else
        thbreak $arg0
    end
end
document bht
Usage: bht LOCATION
| Set a temporary hardware breakpoint.
| This breakpoint will be automatically deleted when hit!
| LOCATION may be a line number, function name, or "*" and an address.
end


# ______________process information____________
define argv
    show args
end
document argv
Syntax: argv
| Print program arguments.
end


define stack
    if $argc == 0
        info stack
    end
    if $argc == 1
        info stack $arg0
    end
    if $argc > 1
        help stack
    end
end
document stack
Syntax: stack <COUNT>
| Print backtrace of the call stack, or innermost COUNT frames.
end


define frame
    info frame
    info args
    info locals
end
document frame
Syntax: frame
| Print stack frame.
end


