%Impulse Response Measurement
blank = zeros(256,256);

h = 1/4*[1 2 1];

%Decimation
blankX1 = deci(blank,h);
blankX2 = deci(blankX1,h);
blankX3 = deci(blankX2,h);
blankX4 = deci(blankX3,h);

%Interpolation
blankY0 = interpol(blankX1,h);
blankY0 = blank-blankY0;
blankY1 = interpol(blankX2,h);
blankY1 = blankX1-blankY1;
blankY2 = interpol(blankX3,h);
blankY2 = blankX2-blankY2;
blankY3 = interpol(blankX4,h);
blankY3 = blankX3-blankY3;

%Addition of Impulse
imp_amp = 1000;
blankY1 = func_impulse(blankY1, imp_amp);


%Interpolation
blankZ3 = interpol(blankX4,h) + blankY3;
blankZ2 = interpol(blankZ3,h) + blankY2;
blankZ1 = interpol(blankZ2,h) + blankY1;
blankZ0 = interpol(blankZ1,h) + blankY0;

E = sqrt(sum(blankZ0(:).^2))/imp_amp
draw(blankZ0)