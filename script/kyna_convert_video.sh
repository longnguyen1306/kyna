#folder source chưa chuyển
IN="/data1/content/vod"

#folder xuất video
OUT="/data1/content/game"

#biến đếm
declare -i COUNT_CONVERTED_FILE=0

#scan folder source 
scanFileInFolder() {
	listDirectory=$(find $1 -type d)
	for directory1 in $listDirectory; do
		copyFile $directory1 $2
	done
}

#kiểm tra sự tồn tại của file ở folder xuất video
checkFileExist(){
	flag=0
	inFileName=$(echo $1 | rev | cut -d "/" -f1 | rev)
	listDirectoryIn=$(find $2/$pathName -type f)
	for fileInOut in $listDirectoryIn; do
		outFileName=$(echo $fileInOut | rev | cut -d "/" -f1 | rev) 
    		if [[ $inFileName == $outFileName ]]; then
			#echo "co cmn roi"
			flag=1
			break
		fi
	done
	return $flag
}

#tiến hành convert file
convertFile(){
    	ffmpeg -i  $1  -filter:v scale=$2 -c:a copy $3
}

copyFile(){
	directory="$1/*.mp4"
	for file in $directory; do
		inFileName=$(echo $file | rev | cut -d "/" -f1 | rev)
		checkFileExist $inFileName $2

		if [[ $flag -eq 0 ]]; then
			folderId=$(echo $file | rev | cut -d "/" -f2 | rev )
			newFile=$2/$pathName/$folderId/$inFileName
			#echo $newFile
			if [[ ! -e $2/$pathName/$folderId ]]; then
              			mkdir -p $2/$pathName/$folderId
				echo "da tao folder "$folderId
         		fi
		#	ghi log
			echo "=======================================================" >> kyna_logs.txt
            		echo "Parsing $file" >> kyna_logs.txt
			convertFile $file $qlt $newFile
			COUNT_CONVERTED_FILE=COUNT_CONVERTED_FILE+1
		elif [[ $flag -eq 1 ]]; then
			echo "Da ton tai " $inFileName
		fi
	done
}

if [ "$1" == "hd" ]; then
	qlt="1280x720"
	pathName=$1
	
	scanFileInFolder $IN $OUT

	echo "Da convert " $COUNT_CONVERTED_FILE "file"
		
elif [ "$1" == "sd" ]; then
	qlt="640x360"
	pathName=$1
        
	scanFileInFolder $IN $OUT

	echo "Da convert " $COUNT_CONVERTED_FILE "file"
	
else
	echo "Dinh dang video khong hop le"
fi
[ "$1" == "" ] && { echo "Nhap vao dinh dang video"; exit 1; }


