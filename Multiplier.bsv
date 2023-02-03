package Multiplier;

  interface Multiplier_IFC;
    method Action start(Int#(32) x, Int#(32) y);
    method Int#(32) result();
  endinterface

  (* synthesize *)
  module mkMultiplier (Multiplier_IFC);
    Reg#(Int#(7)) ctr <- mkReg(32);

    Reg#(Int#(32)) a <- mkRegU;
    Reg#(Int#(32)) b <- mkRegU;

    Reg#(Int#(32)) resultReg <- mkReg(0);

    rule shiftAdd (((b & 32'd1) == 1) && (ctr < 32));
      resultReg <= resultReg + a;
      a <= a << 1;
      b <= b >> 1;
      ctr <= ctr + 1;
    endrule

    rule shift (((b & 32'd1) == 0) && (ctr < 32));
      a <= a << 1;
      b <= b >> 1;
      ctr <= ctr + 1;
    endrule

    method Action start(Int#(32) x, Int#(32) y) if (ctr >= 32);
      a <= x; b <= y;
      ctr <= 0; resultReg <= 0;
    endmethod

    method Int#(32) result() if (ctr >= 32);
      return resultReg;
    endmethod
  endmodule

endpackage
