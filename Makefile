# make kernel_5_6
#
# make fip ARGS="--arg broken true"

TARGETS:=fip uboot sdImage

print:
	@echo $(TARGETS) | tr ' ' '\n'

$(TARGETS):
	@nix-build release.nix -k -A $@ $(ARGS)

.PHONY: @(TARGETS)

