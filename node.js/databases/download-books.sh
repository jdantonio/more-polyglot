#!/usr/bin/env sh

echo 'Downloading from Project Gutenberg...'
curl -O http://www.gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2

echo 'Extracting archive...'
tar -xvjf rdf-files.tar.bz2

echo 'Making the test directory...'
mkdir test

echo 'Copying the required RDF file...'
cp cache/epub/132/pg132.rdf test/

echo 'Done'
