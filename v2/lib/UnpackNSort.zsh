#!/bin/zsh

echo "This script attempts to detect libraries, unpack them to their folders, and then add them to the .csv.
This is kinda jury-rigged together, your mileage may vary

[Pre-flight checks]"

if [ ! -d ./dl ]; then
    echo "Downloads directory does not exist! Create it?"
    read answer

    answer_lowercase=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [ "$answer_lowercase" = "yes" ]; then
        mkdir dl
        echo "Created dir."
    elif [ "$answer_lowercase" = "no" ]; then
        echo "Exiting."
    else
        echo "Please enter either 'yes' or 'no'."
    fi

        exit
else
    echo "Found dir. Proceeding."
fi



if ls "dl"/*.zip >/dev/null 2>&1; then
    echo "Found zip files inside the folder. Proceeding."
else
    echo "No zip files found in the folder."
    exit
fi

echo "[Pre-flight checks completed]"


mkdir -p mod
mkdir -p sym
mkdir -p 3d

(cd dl || exit
mkdir "temp"

(
echo "[Processing zip archives]"
cd temp || exit
unzip -oq "../*.zip"
rm ./*.txt
rm ./*.bin
for dir in ./*
do
  (
    cd "$dir/KiCad" || exit
    cp -r ./*.kicad_sym ../../../../sym
    cp -r ./*.kicad_mod ../../../../mod
  )
  (
    cd "$dir/3D" || exit
    #cp -r ./*.stp ../../../../3d/${dir:t:r}.stp
    cp -r ./*.stp ../../../../3d/
  )
done
)
rm -r temp
)

echo "[Moving files to locations]"
mkdir -p ./mod/temp
for dir in ./mod/*
do
  if  [[ "${dir:t:r}" != "temp" ]]
  then
    mv "${dir}" "./mod/temp/${${dir:t}:s/,/_}"
    mv ./mod/temp/* ./mod
  fi
done

echo "[Cleaning up]"
rm -r ./mod/temp

exit

# I don't particularly like this part, so I'm avoiding it.

echo "Delete archives?"
read answer

answer_lowercase=${$(echo "$answer" | tr '[:upper:]' '[:lower:]'):0:1}

if [ "$answer_lowercase" = "y" ]; then
    cd dl
    #rm -r ./*
elif [ "$answer_lowercase" = "n" ]; then

else
    echo "Please enter either 'yes' or 'no'."
fi

echo "[Done.]"



