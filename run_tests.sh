#!/bin/bash

SCHEME='Movies'
DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 15'

xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'
