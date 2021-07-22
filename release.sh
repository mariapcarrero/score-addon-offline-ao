#!/bin/bash
rm -rf release
mkdir -p release

cp -rf AudioOracle *.{hpp,cpp,txt,json} LICENSE release/

mv release score-addon-audiooracle
7z a score-addon-audiooracle.zip score-addon-audiooracle
