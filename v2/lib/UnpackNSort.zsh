#!/bin/zsh

mkdir -p Footprints
mkdir -p Symbols

(cd Downloads || exit
mkdir "temp"

(
cd temp || exit
unzip -oq "../*.zip"
rm ./*.txt
rm ./*.bin

for dir in ./*
do
  (
    cd "$dir/KiCad" || exit
    cp -r ./*.dcm ../../../../Symbols
    cp -r ./*.kicad_sym ../../../../Symbols
    mkdir -p ../../../../Footprints/${dir:t:r}
    cp -r ./*.kicad_mod ../../../../Footprints/${dir:t:r}
  )
  (
    cd "$dir/3D" || exit
    cp -r ./*.stp ../../../../Footprints/${dir:t:r}
  )
done
)
rm -r temp
)

template="temp"
mkdir -p ./Footprints/temp
for dir in ./Footprints/*
do
  if  [[ "${dir:t:r}" != "temp" ]]
  then
    mv "${dir}" "./Footprints/temp/${${dir:t}:s/,/_}"
    mv ./Footprints/temp/* ./Footprints
  fi
done
rm -r ./Footprints/temp

echo "Rebuild symbol and footprint tables? (y/n)"
read -r choice

# shellcheck disable=SC2154
if [[ $choice -eq "y" ]] || [[ $choice -eq "Y" ]]
then
  echo "Rebuilding symbol tables..."
  echo "(sym_lib_table\n  (version 7)" > sym-lib-table
  for sym in ./Symbols/*.kicad_sym
  do
    echo "  (lib (name \"${${sym:t}:s/,/_}\")(type \"KiCad\")(uri \"\${KIPRJMOD}/lib/Symbols/${${sym:t}:s/,/_}\")(options \"\")(descr \"\"))" >> sym-lib-table
  done
  echo ")" >> sym-lib-table
  echo "Done rebuilding symbol table"

  echo "Rebuilding footprint tables..."
  echo "(fp_lib_table\n  (version 7)" > fp-lib-table
  for sym in ./Footprints/*
  do
    echo "  (lib (name \"${${sym:t:r}:s/,/_}\")(type \"KiCad\")(uri \"\${KIPRJMOD}/lib/Footprints/${${sym:t:r}:s/,/_}\")(options \"\")(descr \"\"))" >> fp-lib-table
  done
  echo ")" >> fp-lib-table
  echo "Done rebuilding footprint table"
fi

mv sym-lib-table ../
mv fp-lib-table ../



