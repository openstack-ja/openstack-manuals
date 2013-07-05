#!/bin/bash

git checkout trans-ja-opsguide
./tools/generatedocbook -l ja -b openstack-ops
cd generated/ja/openstack-ops/
sed -i 's/1.7.3-SNAPSHOT/1.8.1-SNAPSHOT/' pom.xml
sed -i -e '/webhelpDirname/a\                            <webhelpIndexerLanguage>ja</webhelpIndexerLanguage>' pom.xml
mvn clean generate-sources
cd -
git checkout gh-pages
rm -rf openstack-ops/
cp -pr generated/ja/openstack-ops/target/docbkx/webhelp/local/openstack-ops .
