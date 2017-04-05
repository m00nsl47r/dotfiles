#!/usr/bin/zsh
tempfile="$(mktemp -d "${TMPDIR:-/tmp/}$(basename 0).XXXX")/ALL.nanorc"

dotfiles="$HOME/.dotfiles"
nanod="${dotfiles}/nanod"
nanosyn="${nanod}/syntax"


if ! [ -d ${nanod} ] || ! [ -d ${nanosyn} ]; then
    print "Directories not found, is your .dotfiles configured?"
    exit
fi

deffiles="${(@f)$(ls ${nanod}/syntax)}"
for defs in "${deffiles}"; do
    cat $defs >> ${tempfile}
    cat ${tempfile}|less
done

# copy the file
allfile=$nanod/"ALL.nanorc"
if [ -e $nanod/$allfile ]; then
    print "${allfile} already exists. Backing up to ${allfile}.bak"
    mv "$allfile" "${allfile}.bak"
    print "created ${allfile}.bak"
fi
cp "${tempfile}" "${allfile}"
