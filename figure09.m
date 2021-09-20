%% passive and active are opposite here
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];
file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
grd = load_roms_grid(file_grd_sp);

h = rnt_2grid(grd.h, 'r', 'p');
df = 0;

%% 
for target_year = 2014:2016
    figure(214)
    for ii = 1:2
        sb(ii)=subplot(1,2,ii)
        sc = 300;
        switch ii
            case 1
                ens = 'passive';
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens1.mat'])
                Data1 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens2.mat'])
                Data2 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens3.mat'])
                Data3 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                a=0; b=600; c=1e-4; d=5e-2;
                xl = 'Transport';
                yl = 'Active';
            case 2
                ens = 'active';
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens1.mat'])
                Data1 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens2.mat'])
                Data2 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                    ens, '-SP-Final-MEANb-Aug-', num2str(target_year), '-transport-100m-ens3.mat'])
                Data3 = sqrt(Quz100_8 .^ 2 + Qvz100_8 .^ 2);
                a=0; b=600; c=1e-4; d=5e-2;
                xl = 'Transport';
                yl = 'Passive';
        end
        
        switch target_year
            case 2014
                cc = [169,169,169]/255; % grey
            case 2015
                cc = 'b'; % blue
            case 2016
                cc = 'g'; % green
        end
        XX = [];
        FF = [];
        
        data = grd.maskp .* nanmean(Data1,3);
        data(h(:) <= df) = NaN;
        X = data(:);
        X(isnan(X)) = [];
        [f, x] = calcPdf(X, sc);
        semilogy(x, f, '-', 'color', cc, 'linewidth', 0.5)
        XX = [XX; x];
        FF = [FF, f];
        
        hold on
        data = grd.maskp .* nanmean(Data2,3);
        data(h(:) <= df) = NaN;
        X = data(:);
        X(isnan(X)) = [];
        [f, x] = calcPdf(X, sc);
        semilogy(x, f, '-', 'color', cc, 'linewidth', 0.5)
        XX = [XX; x];
        FF = [FF, f];
        
        data = grd.maskp .* nanmean(Data3,3);
        data(h(:) <= df) = NaN;
        X = data(:);
        X(isnan(X)) = [];
        [f, x] = calcPdf(X, sc);
        semilogy(x, f, '-', 'color', cc, 'linewidth', 0.5)
        XX = [XX; x];
        FF = [FF, f];
        
        for zz = 1:3
            x0 = XX(1,:);
            xz = XX(zz,:);
            fz = FF(:,zz);
            if zz == 1
                RES = FF(:,1);
            else
                RES(:,zz) = interp1(xz, fz, x0);
            end
        end
        RES(isnan(RES)) = 0;
        mean_ = nanmean(RES,2);

        if target_year == 2014
            semilogy(x0, mean_, '-', 'color', 'k', 'linewidth', 1.5)
        elseif target_year == 2015
            semilogy(x0, mean_, '-', 'color', [0, 0.4470, 0.7410], 'linewidth', 1.5)
        else
            semilogy(x0, mean_, '-', 'color', [0, 0.5, 0], 'linewidth', 1.5)
        end
        box on
        axis([a, b, c, d])
        xlabel(xl)
        ylabel(yl)
%         if ii == 6
%             legend('2014 ens1', '2014 ens2', '2014 ens3', '2014 mean', '2015 ens1', ...
%                 '2015 ens2', '2015 ens3', '2015 mean', '2016 ens1', '2016 ens2', '2016 ens3', '2016 mean')
%         end
    end
end
set(gcf, 'position', [2 42 958 1074])
