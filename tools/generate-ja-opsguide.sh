#!/bin/bash

git checkout trans-ja-opsguide
./tools/generatedocbook -l ja -b openstack-ops
cd generated/ja/openstack-ops/
mvn clean generate-sources
cd -
git checkout gh-pages
rm -rf openstack-ops/
cp -pr generated/ja/openstack-ops/target/docbkx/webhelp/local/openstack-ops .
