
compile:
	#bsc -u -sim -simdir build_bsim -bdir build_bsim -info-dir build_bsim -keep-fires -aggressive-conditions -p .:./src_BSV:%/Prelude:%/Libraries -g multiplierTB src_BSV/Testbench.bsv
	bsc -sim Multiplier.bsv
	bsc -sim MultiplierTB.bsv
	bsc -sim -o multiplier-test.bexe -e mkMultiplierUnitTH mkMultiplier.ba mkMultiplierUnitTH.ba
