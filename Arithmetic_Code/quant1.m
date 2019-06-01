function q = quant1(x, step, rise1)

% QUANT1 Quantise a matrix
%  Q = QUANT1(X, step, rise1) quantises the matrix X using steps
%  of width step.
%
%  The result is the quantised integers Q. If rise1 is defined,
%  the first step rises at rise1, otherwise it rises at step/2 to
%  give a uniform quantiser with a step centred on zero.
%  In any case the quantiser is symmetrical about zero.

if step <= 0, q = x; return, end

if nargin <= 2, rise1 = step/2; end

% Quantise abs(x) to integer values, and incorporate sign(x)..
q = max(0,ceil((abs(x) - rise1)/step)) .* sign(x);


