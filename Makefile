TEXT_PAGINATION := true
LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update --init
else
ifneq (,$(wildcard $(ID_TEMPLATE_HOME)))
	ln -s "$(ID_TEMPLATE_HOME)" $(LIBDIR)
else
	git clone -q --depth 10 -b main \
	    https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
endif


sourcecode: draft-lenders-dns-cbor.xml
	rm -rf sourcecode.ba?
	sed -i 's/6\.TBDt/6\.7/g' draft-lenders-dns-cbor.xml
	kramdown-rfc-extract-sourcecode -tfiles $<
