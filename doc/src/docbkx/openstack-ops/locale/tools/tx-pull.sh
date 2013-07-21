#!/bin/sh

tx pull -f -l ja -r openstack-manuals-i18n.openstack-ops
msgcat -F ja.po > $$; mv $$ ja.po
