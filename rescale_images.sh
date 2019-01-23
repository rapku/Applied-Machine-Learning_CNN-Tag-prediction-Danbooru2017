rescale512px() {
    ID=$( basename "$@"  | cut -d '.' -f 1)
    EXT=$( basename "$@" | cut -d '.' -f 2)
    # echo $EXT
    BUCKET=$(printf "%04d" $(( $ID % 1000 )) )
    # avoid animated GIFs: exploded in multiple JPGs by ImageMagick, they break the 1 ID == 1 file assumption, the associated metadata like tags may be completely wrong, and as multiple JPGs they look awful
    #Added the JPEG:SIZE hint and after 820000
    if [[ ! -a ./512px/$BUCKET/$ID.jpg ]] && [[ $EXT -ne "gif" ||  $(identify -format %n "$@") -eq 1 ]]; then
        convert -resize 512x512\> -extent 512x512\> -limit thread 1 -gravity center -background black "$@" ./512px/$BUCKET/$ID.jpg
    fi }
export -f rescale512px
find_images() {
    find original/ -type f -iname "*.jp*g" -or -iname "*.png" -or -iname "*.gif" -or -iname "*.bmp"
}
export -f find_images
find_images | tail -n +1800000 | parallel -j6 --progress --no-notice --joblog=../resize_log.txt rescale512px
# delete any exploded JPG forms of animated GIFs; they're no good for anything:
find 512px/ -type f -name "*-[[:digit:]]*.jpg" -delete

