function b=bpp(x)

% BPP Calculate entropy
%
%  b = BPP(x) Calculates the entropy in bits per element (or pixel) for the
%  matrix x.
%
%  The entropy represents the number of bits per element to encode x
%  assuming an ideal first-order entropy code.

minx = min(min(x));
maxx = max(max(x));

% Calculate histogram of x in bins defined by  bins.
bins = [floor(minx):ceil(maxx)];
 if length(bins)<2
   b = 0; % in this case there is no information, since all the values are identical
   return
else
  [h,s] = hist(x(:),bins);
end

% bar(s,h)
% figure(gcf)

% Convert bin counts to probabilities, and remove zeros.
p = h / sum(h);
p = p(find(p > 0));

% Calculate the entropy of the histogram using base 2 logs.
b = -sum(p .* log(p)) / log(2);

return
