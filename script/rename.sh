IN=$1

listDirectory=$(find $IN -type f)
for directory1 in $listDirectory; do
        fileName=$(echo $directory1 | rev | cut -d "/" -f1 | rev)
        idfolder=$(echo $directory1 | rev | cut -d "/" -f2 | rev)
        newName=$(echo $fileName | rev | cut -d "_" -f2 | rev )".mp4"
        #       mv $fileName $newName
        mv $directory1 $1/$idfolder/$newName

        echo $newName
done