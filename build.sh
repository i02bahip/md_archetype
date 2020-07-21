OPTIND=1         # Reset in case getopts has been used previously in the shell.

# clean the /out directory if it already exists
if test -d out
then
	echo "cleaning out directory"
	rm -r out/*
else
	mkdir out	
fi

# assemble main.asm 
asmx -C 68000 -e -w -b 0 -l out/rom.lst -o out/rom.bin -- main.asm

# check for options
while getopts ":d" opt; do
    case "$opt" in
    d)
        echo "debug selected - starting mess" >&2
		gnome-terminal -e "/home/rene/Dev/blastem64-0.5.1/blastem -d out/rom.bin"
		#mess genesis -cart out/rom.bin -debug
        ;;
	\?)
		echo "Invalid Option: -$OPTARG" >&2
		;;
    esac
done

# Shift off the options and optional --.
shift "$((OPTIND-1))"
