.PHONY: test install uninstall

test:
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal_init.lua' }"

install:
	DRY_RUN=$(DRY_RUN) bash install.sh

uninstall:
	YES_TO_ALL=$(YES_TO_ALL) bash uninstall.sh
