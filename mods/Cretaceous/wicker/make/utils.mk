ifndef SCRIPT_DIR
 $(error SCRIPT_DIR is not defined)
endif
ifndef WICKER_TOOLS_DIR
 $(error WICKER_TOOLS_DIR is not defined)
endif

ifndef WICKER_SCRIPT_DIR
 WICKER_SCRIPT_DIR:=scripts/wicker
endif

wicker:
	-git subtree pull --prefix $(WICKER_SCRIPT_DIR) https://github.com/nsimplex/wicker.git master --squash
	-git subtree pull --prefix $(WICKER_TOOLS_DIR) https://github.com/nsimplex/wickertools.git master --squash

boot: $(WICKER_TOOLS_DIR)/bootup_gen.pl
	find "$(SCRIPT_DIR)" -type f -name '*.lua' -exec perl "$<" '{}' mod \;
