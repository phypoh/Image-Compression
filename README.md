# image_compression
Third Year Design Project SF2: Image Processing

Collaborators: Cindy Lam and Phyllis Poh


## Scripts added to template code:
### main.m
Overall super-scheme, that compresses and compares images, then returns the image with the best image quality that fits the bit limit)

### func_dwtstepmse.m
Function which generates and returns dwtstep, a matrix of step sizes to be used for DWT

### func_quantdwt.m and func_invquantdwt.m
Function (and it's corresponding inverse) which performs DWT quantisation on the image, given matrix dwtstep and number of levels

### func_multilevel.m and func_multiinverse.m
Function (and it's corresponding inverse) which perform Discrete Wavelet Transform on the image.

### step_optimise_lbt.m and step_optimise_dwt_mse.m
Functions which find the optimal step size, compressing using LBT and DWT (MSE scheme) respectively which correspond to an rms error of the same value for Xq. Other scripts involed: func_rms_quantise_lbt.m and func_rms_quantise_dwt_mse.m

### vary_rise1.m and quantiseRise.m
Scripts used to investigate the effect of changing Rise1 for the quantise function.
