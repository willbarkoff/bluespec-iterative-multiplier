//========================================================================
// Test harness for greatest common divisor unit
//========================================================================

import Multiplier::*;

//------------------------------------------------------------------------
// Helper function
//------------------------------------------------------------------------

function Action verify( Int#(32) testResult, Int#(32) correctResult );
  if ( testResult == correctResult )
    $display( "  [ passed ] %d == %d ", testResult, correctResult );
  else
    $display( "  [ FAILED ] %d != %d ", testResult, correctResult );
endfunction

typedef enum 
{ 
  Test1Start, Test1Finish, 
  Test2Start, Test2Finish,
  Test3Start, Test3Finish,
  Test4Start, Test4Finish,
  Test5Start, Test5Finish,
  Done 
} 
State deriving(Eq,Bits);

//------------------------------------------------------------------------
// Main test harness module
//------------------------------------------------------------------------


(* synthesize *)
module mkMultiplierUnitTH( Empty );
  
  Multiplier_IFC mul <- mkMultiplier ();
  
  Reg#(State) state <- mkReg (Test1Start);

  // ------ TEST 1 ------

  rule test1Start (state == Test1Start);
    mul.start( 2, 2 );
    state <= Test1Finish;
  endrule

  rule test1Finish (state == Test1Finish);
    verify( mul.result(), 4 );
    state <= Test2Start;
  endrule

  // ------ TEST 2 ------

  rule test2Start (state == Test2Start);
    mul.start( 471, 102 );
    state <= Test2Finish;
  endrule

  rule test2Finish (state == Test2Finish);
    verify( mul.result(),  48042 );
    state <= Test3Start;
  endrule

  // ------ TEST 3 ------

  rule test3Start (state == Test3Start);
    mul.start(5, 7);
    state <= Test3Finish;
  endrule

  rule test3Finish (state == Test3Finish);
    verify(mul.result(), 35);
    state <= Test4Start;
  endrule 

  // ------ TEST 4 ------

  rule test4Start (state == Test4Start);
    mul.start(20, 84);
    state <= Test4Finish;
  endrule

  rule test4Finish (state == Test4Finish);
    verify(mul.result(), 1680);
    state <= Test5Start;
    $finish;
  endrule

endmodule
