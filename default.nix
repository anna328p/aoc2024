{ flakes
, stdenv
, lib
, hyperfine
, valgrind
, gprof2dot
, graphviz
}:

stdenv.mkDerivation {
	pname = "TODO";
	version = "0";

	nativeBuildInputs = [
		hyperfine
		valgrind
		gprof2dot
		graphviz
	];

	buildInputs = [

	];

	meta = {
		maintainers = [ lib.maintainers.anna328p ];
	};
}
