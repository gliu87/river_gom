%% plot timeseris area, volume with river discharge
%% note, because of naming systme, sometimes passive and active are in wrong position.
ens_ = {'noriver', 'active', 'passive', 'active', 'passive'};
res_ = {'SP', 'SP', 'SP', 'MR', 'MR'};

HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];
file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
file_grd_mr = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
grdSP = load_roms_grid(file_grd_sp);
grdMR = load_roms_grid(file_grd_mr);

color_ = [
    1, 0, 0; ...
    0, 0.5, 0; ...
    0.75, 0, 0.75; ...
    0, 0.5, 0; ...
    0.75, 0, 0.75];
style_ = {'-', '-', '-', '--', '--'};
width_ = [2, 2, 2, 1, 1];
fs1 = 16; fs2 = 18;

for ii = 1:length(ens_)
    ens = ens_{ii};
    res = res_{ii};
    
    switch res
        case 'SP'
            grd = grdSP;
        case 'MR'
            grd = grdMR;
    end
    
    for jj = 1:8
        matfile = [HOME_DIR, 'Data_River\Processed_Data\area-vol-cor-', res, ...
            '-', ens, '-averaged', num2str(jj), '.mat'];
        load(matfile, 'Area', 'TIME', 'Volume')
        
        area_whole = nansum(squeeze(nansum(Area,2)), 1);
        volume_whole = nansum(squeeze(nansum(Volume,2)), 1);
        
        filter1 = grd.h >= 50;
        filter1 = double(filter1);
        filter1 = filter1 .* grd.maskr;
        filter1(filter1 == 0) = NaN;
        
        for tt = 1:length(TIME)
            zz_a = Area(:,:,tt) .* filter1;
            zz_v = Volume(:,:,tt) .* filter1;
            area_1(tt) = nansum(nansum(zz_a));
            volume_1(tt) = nansum(nansum(zz_v));
            clear zz_a zz_v
        end
            
        if jj == 1
            AreaWhole = area_whole;
            VolumeWhole = volume_whole;
            Area1 = area_1;
            Volume1 = volume_1;
            Time = TIME;
        else
            AreaWhole = [AreaWhole, NaN, area_whole];
            VolumeWhole = [VolumeWhole, NaN, volume_whole];
            Area1 = [Area1, NaN, area_1];
            Volume1 = [Volume1, NaN, volume_1];
            Time = [Time; Time(end)+1; TIME];
        end
        clear Area Volume TIME matfile area_1 volume_1 
        clear area_whole volume_whole
    end
    
    data1 = (Area1) ;
    data2 = (Volume1);

    figure(213)
    set(gcf, 'Position', [1, 41, 1920, 1083])
    sb(1)=subplot(3,2,1);
    hold on
    plot(datetime(datestr(Time)), data1, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 5.5e11])
    %ylim([0, 50])
    switch ii
        case 5
            ylabel('Area (m^2)', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2014-01-01'), 4.8e11, '2014', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on
    xlim([datetime('2013-12-01'), datetime('2014-12-31')])
    aaa = get(sb(1),'XTickLabel');
    set(sb(1),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-2)
    
   
    sb(3)=subplot(3,2,3);
    hold on
    plot(datetime(datestr(Time)), data1, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 5.5e11])
    %ylim([0, 50])
    switch ii
        case 5
            ylabel('Area (m^2)', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2015-01-01'), 4.8e11, '2015', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on 
    xlim([datetime('2014-12-01'), datetime('2015-12-31')])
    aaa = get(sb(3),'XTickLabel');
    set(sb(3),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-2)

    
    sb(5)=subplot(3,2,5);
    hold on
    plot(datetime(datestr(Time)), data1, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 5.5e11])
    %ylim([0, 50])
    switch ii
        case 5
            ylabel('Area (m^2)', 'FontName', 'Helvetica', 'FontSize', fs1)
            xlabel('Time', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2016-01-01'), 4.8e11, '2016', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on
    xlim([datetime('2015-12-01'), datetime('2016-12-31')])
    aaa = get(sb(5),'XTickLabel');
    set(sb(5),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-2)
    
    sb(2)=subplot(3,2,2);
    hold on
    plot(datetime(datestr(Time)), data2, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 7e12])
    %ylim([0, 50])
    switch ii
        case 5
            ylabel('Volume (m^3)', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2014-01-01'), 6.1e12, '2014', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on
    xlim([datetime('2013-12-01'), datetime('2014-12-31')])
    aaa = get(sb(2),'XTickLabel');
    set(sb(2),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-2)
    
    sb(4)=subplot(3,2,4);
    hold on
    plot(datetime(datestr(Time)), data2, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 7e12])
    %ylim([0, 50])
    switch ii
        case 5
            ylabel('Volume (m^3)', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2015-01-01'), 6.1e12, '2015', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on
    xlim([datetime('2014-12-01'), datetime('2015-12-31')])
    aaa = get(sb(4),'XTickLabel');
    set(sb(4),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-1)
    
    sb(6)=subplot(3,2,6);
    hold on
    plot(datetime(datestr(Time)), data2, ...
        'linewidth', width_(ii), 'linestyle', style_{ii}, 'color', color_(ii,:))
    ylim([0, 7e12])
    %ylim([0, 50])
    switch ii
        case 5
            legend({'SP-noriver', 'SP-passive', 'SP-active', 'MR-passive', 'MR-active'}, ...
                 'FontName', 'Helvetica', 'FontSize', fs1-4)
            xlabel('Time', 'FontName', 'Helvetica', 'FontSize', fs1)
            ylabel('Volume (m^3)', 'FontName', 'Helvetica', 'FontSize', fs1)
            text(datetime('2016-01-01'), 6.1e12, '2016', 'FontName', ...
                'Helvetica', 'FontSize', fs2, 'fontweight', 'bold')
    end
    box on
    xlim([datetime('2015-12-01'), datetime('2016-12-31')])
    aaa = get(sb(6),'XTickLabel');
    set(sb(6),'XTickLabel',aaa,'FontName','Helvetica','fontsize',fs1-2)
end

set(gcf, 'Position', [1, 41, 1920, 1083])

pos = get(sb(1), 'position')
pos(3) = 0.25;
pos(4) = 0.2;
set(sb(1), 'position', pos)

pos = get(sb(2), 'position')
pos(1) = 0.42;
pos(3) = 0.25;
pos(4) = 0.2;
set(sb(2), 'position', pos)

pos = get(sb(3), 'position')
pos(3) = 0.25;
pos(4) = 0.2;
pos(2) = 0.445;
set(sb(3), 'position', pos)

pos = get(sb(4), 'position')
pos(1) = 0.42;
pos(3) = 0.25;
pos(4) = 0.2;
pos(2) = 0.445;
set(sb(4), 'position', pos)

pos = get(sb(5), 'position')
pos(3) = 0.25;
pos(4) = 0.2;
pos(2) = 0.18;
set(sb(5), 'position', pos)

pos = get(sb(6), 'position')
pos(1) = 0.42;
pos(3) = 0.25;
pos(4) = 0.2;
pos(2) = 0.18;
set(sb(6), 'position', pos)