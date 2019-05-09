function [y] = quantise(x, step, rise1)

% QUANTISE Quantise a matrix in one step
%  Y = QUANTISE(X, step, rise1) Quantises X using steps of width step,
%  using quant1 and quant2.
%
%  If rise1 is defined, the first step rises at rise1, otherwise it rises at
%  step/2 to give a uniform quantiser with a step centred on zero.
%  In any case the quantiser is symmetrical about zero.

if step <= 0, y = x; return, end

if nargin <= 2, rise1 = step/2; end

% Perform both quantisation steps
y = quant2(quant1(x, step, rise1), step, rise1);

