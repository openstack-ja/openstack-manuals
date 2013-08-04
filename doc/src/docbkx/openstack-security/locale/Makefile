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
	msgcat -F -o $(TMPFILE) $(POTFILE)
	mv $(TMPFILE) $(POTFILE)

stats:
	@for f in chap/*.ja.po; do \
	  n=`basename $$f .ja.po`; \
	  echo -n "$$n: "; \
	  LANG=C msgfmt -o /dev/null --statistics $$f; \
	done 2>&1 | $(TOOLDIR)/format-po-stats.py
