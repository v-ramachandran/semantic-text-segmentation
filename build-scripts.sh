if [ -d bin ]; then
 rm -rf bin
 mkdir bin
fi

RUBY_BIN_SCRIPTS=lib/ruby/bin/*;
for i in $RUBY_BIN_SCRIPTS;
do
 ln -s $(cd $(dirname $i); pwd)/$(basename $i) bin/$(basename -s .rb $i)
done
chmod +x bin/*
