POTFILE = openstack-security.pot
POFILE = ja.po

TOPDIR = ../../../../..
TOOLDIR = $(TOPDIR)/tools

TMPFILE = __tmp__.po

all:	merge

# Merge all per-chapter PO files into ja.po and sync with POT file
merge:
	$(TOOLDIR)/chap-merge.sh $(POFILE) $(POTFILE)
	msgfmt --statistics -o /dev/null $(POFILE)

# Update per-chapter PO files based on ja.po
# The only case where it requires is when POT file is updated
split:
	$(TOOLDIR)/chap-split.sh $(POFILE)

update-pot:
	cd $(TOPDIR) && ./tools/generatepot openstack-security
	msgcat -F -o $(POTFILE) $(POTFILE)
