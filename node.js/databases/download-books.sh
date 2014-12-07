#!/usr/bin/env sh

echo 'Downloading from Project Gutenberg...'
curl -O http://www.gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2

echo 'Extracting archive...'
tar -xvjf rdf-files.tar.bz2

echo 'Making the test directory...'
mkdir test

echo 'Copying the required RDF file...'
cp cache/epub/132/pg132.rdf test/

#echo 'Creating the book database...'
#./dbcli.js -m PUT -p books

#echo 'Importing books into the database...'
#./import-books.js

#$ ./dbcli.js -m GET -p books
#$ ./dbcli.js -m GET -p books/0
#200 { _id: '0',
  #_rev: '1-453265faaa77a714d46bd72f62326186',
  #title: '',
  #authors: [],
  #subjects: [] }
#$ ./dbcli.js -m DELETE -p books/0?rev=1-453265faaa77a714d46bd72f62326186

echo 'Done'
