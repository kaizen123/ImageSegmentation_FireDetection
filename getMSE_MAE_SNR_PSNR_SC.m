function [mse, mae, snr, psnr, SC]=getMSE_MAE_SNR_PSNR_SC(frameReference,frameUnderTest)
s1=(double(frameReference)-double(frameUnderTest)).^2;
s2=abs(double(frameReference) - double(frameUnderTest));
s3=double(frameReference).^2;
s4=double(frameReference).^2;
s4=sum(s4(:));
s5=double(frameUnderTest).^2;
s5=sum(s5(:));
    
    sse = sum(s1(:));
    range = double(size(frameReference,1)*size(frameReference,2)*size(frameReference,3));
    mse  = sse / range;
    mae = sum(s2(:)) / range;
    SC = s4 / s5;
    if( sse <= 1e-10) 
        snr = 100;
        psnr=100;
    else
        snr = sum(s3(:)) / sse;
        psnr = 10.0 * log10((255^2) / mse);
    end
end