#!/usr/bin/env bash

mv db/development.sqlite3 /mnt/d
mv db/test.sqlite3 /mnt/d
ln -s /mnt/d/development.sqlite3 db/development.sqlite3
ln -s /mnt/d/test.sqlite3 db/test.sqlite3