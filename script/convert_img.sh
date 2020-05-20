IN="$1"

checkFileExist(){
	flag=0
	if [[ $1 != *"$2.webp" ]]; then
		inputFile=$(echo $1 | cut -f2 -d".")
	elif [[ $1 == *"$2.webp" ]]; then
		flag=1
        return
	fi

	listFiles=$(find $IN -type f -name "*$2.webp")
	for file in $listFiles; do
	name=$(echo $file | cut -f2 -d".")
		if [[ $inputFile == $name ]]; then
			flag=1
			break
		fi
	done
	return $flag
}
convertImgPng(){ 
	ex=".png"
	imgs=$(find $1 -type f -name "*$ex")	
	for img in $imgs; do 
		checkFileExist $img $ex                                                                                                                                  checkFileExist $img $ex
		if [[ $flag == "0" ]]; then
			cwebp $img -o $img.webp
		fi
	done
}

convertImgJpg(){
    ex=".jpg"
	imgs=$(find $1 -type f -name "*$ex")
	for img in $imgs; do
		checkFileExist $img $ex
		if [[ $flag == "0" ]]; then      
			cwebp $img -o $img.webp
		fi
	done
}

convertImgJpg $IN
convertImgPng $IN
