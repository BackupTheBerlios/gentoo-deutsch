dir="$1"

echo "Removing: $1 from CVS..."
echo -n "Are you sure? [y N] : "
read value

if [ $value = "y" ]; then
  for file in `find $dir ! -type d ! -name Root ! -name Repository ! -name Entries `; do rm -f $file && cvs rm $file ; done
  for dir in `find $dir -type d ! -name CVS `; do cvs rm $dir; done
fi

