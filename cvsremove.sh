dir="$1"

echo "Removing: $1 from CVS..."
echo -n "Are you sure? [y N] : "
read value

if [ $value = "y" ]; then
  for file in `find $1 ! -type d ! -name Root ! -name Repository ! -name Entries `; do echo "removing $file"; rm -f $file && cvs rm $file ; done
  for dir in `find $1 -type d ! -name CVS `; do echo "removing $dir"; cvs rm $dir; done
fi

