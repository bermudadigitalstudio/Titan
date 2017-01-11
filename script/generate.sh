#!/usr/bin/env bash

# Generates the syntactic sugar for titan.

# We loop through each template, stripping the first two lines that declare it as auto generated.
# Sourcery ignores its own outputs. We don't want this! We generate instance methods first,
# then top level sugars!

# Sourcery is not yet API stable, so let's check the exact version"
SOURCERY_VERSION="$(.build/debug/sourcery --version)"
if [ "$SOURCERY_VERSION" != "0.5.0" ]
then
  echo "You need sourcery 0.5.0 – uncomment the line in Package.swift"
  exit 1
fi

# We don't want our pipeline messed up by older versions – delete all generated files!
rm Sources/*.generated.swift

# We don't actually need this code in Titan, but we want to loop through HTTP methods in Templates, so we have to put it somewhere
cat > Sources/HTTPMethods.swift <<EOD
enum HTTPMethod {
  case GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD
}
EOD

for file in "TitanTopLevelSugar"
do
  .build/debug/sourcery Packages/TitanRouter*/Sources Templates/$file.stencil Sources/ # Generate source code
  tail -n +4 Sources/$file.generated.swift > Sources/$file.generated.swift.temp # Trim first three lines of generated file into temp file
  rm Sources/$file.generated.swift # Remove original
  mv Sources/$file.generated.swift.temp Sources/$file.generated.swift # Rename to original
done

rm Sources/HTTPMethods.swift
