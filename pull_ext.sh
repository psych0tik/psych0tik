#!/bin/sh
CWD=`pwd`
GITPATH="$(dirname "$0")"/ext

pull_or_clone() 
    while [ $# -ge 2 ]; do
        cd "$CWD"
        IPATH="$1"; shift
        REPO="$1"; shift
        RCS="$1"; shift

        # Define RCS Data:
        if [ $RCS = "svn" ]; then
            CHECKOUT=checkout
            PULL=update
        elif [ $RCS = "git" ]; then
            CHECKOUT=clone
            PULL=pull
        elif [ $RCS = "hg" ]; then
            CHECKOUT=clone
            PULL=pull
        else
            echo "Broken RCS @ $IPATH"
            continue
        fi

        COPATH="$GITPATH"/"$IPATH"

        if [ ! -d "$COPATH" ]; then
            $RCS $CHECKOUT "$REPO" "$COPATH"
            cd "$COPATH"
            if [ -x __setup.sh ]; then
                echo "Issuing setup commands"
                ./__setup.sh
            fi
        else
            cd "$COPATH"
            echo "pulling from remote in $COPATH"
            $RCS $PULL
            if [ -x __update.sh ]; then
                ./__update.sh
            fi
        fi
        cd "$CWD"
    done


    # Move the referenced apps into an include file so that diff_ and pull_ can both
    # Access them
pull_or_clone \
    psych0tik git@github.com:richoH/psych0tik.git           git\
    irssi-scripts git@github.com:shabble/irssi-scripts.git  git\
    vimprobable git@github.com:richoH/vimprobable.git       git\
    tabbed http://hg.suckless.org/tabbed                    hg\
    openbox natalya.psych0tik.net:git/openbox.git           git\
    hbh     richo@hellboundhackers.org/var/svn              svn\
    fugitive    git://github.com/tpope/vim-fugitive.git     git
