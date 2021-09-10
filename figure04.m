%% note, because of naming systme, sometimes passive and active are in wrong position.
warning('off', 'all')
tic;

%% fixed parameters
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];
target_years = [2014, 2015, 2016];
ori_time = datenum('2013-1-1');
for yy = 2 %1:3 % 2014 to 2016
    target_year = target_years(yy);
    
    % SP-Noriver
    ens = 'noriver';
    res = 'SP';
    
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-thickness-24681012-ens.mat'])
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012-ens.mat'])
    if target_year == 2016
        thick_12 = nan(size(thick_4));
        zeta_12 = nan(size(zeta_4)); 
    end
    data.data1 = thick_4;
    data.data2 = thick_8;
    data.data3 = thick_12;
    zeta.data1 = zeta_4;
    zeta.data2 = zeta_8;
    zeta.data3 = zeta_12;
    clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12
    clear COUNT thick_2 thick_4 thick_6 thick_8 thick_10 thick_12
    
    % SP-Active NOTE, A and P needs to be reversed
    ens = 'passive';
    res = 'SP';
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-thickness-24681012-ens.mat'])
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012-ens.mat'])
    if target_year == 2016
        thick_12 = nan(size(thick_4));
        zeta_12 = nan(size(zeta_4)); 
    end
    data.data4 = thick_4;
    data.data5 = thick_8;
    data.data6 = thick_12;
    zeta.data4 = zeta_4;
    zeta.data5 = zeta_8;
    zeta.data6 = zeta_12;
    clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12
    clear COUNT thick_2 thick_4 thick_6 thick_8 thick_10 thick_12
    
    % SP-Passive NOTE, A and P needs to be reversed
    ens = 'active';
    res = 'SP';
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-thickness-24681012-ens.mat'])
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012-ens.mat'])
    if target_year == 2016
        thick_12 = nan(size(thick_4));
        zeta_12 = nan(size(zeta_4)); 
    end
    data.data7 = thick_4;
    data.data8 = thick_8;
    data.data9 = thick_12;
    zeta.data7 = zeta_4;
    zeta.data8 = zeta_8;
    zeta.data9 = zeta_12;
    clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12
    clear COUNT thick_2 thick_4 thick_6 thick_8 thick_10 thick_12
    
    % MR-Active NOTE, A and P needs to be reversed
    ens = 'passive';
    res = 'MR';
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-thickness-24681012-ens.mat'])
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012-ens.mat'])
    if target_year == 2016
        thick_12 = nan(size(thick_4));
        zeta_12 = nan(size(zeta_4)); 
    end
    data.data10 = thick_4;
    data.data11 = thick_8;
    data.data12 = thick_12;
    zeta.data10 = zeta_4;
    zeta.data11 = zeta_8;
    zeta.data12 = zeta_12;
    clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12
    clear COUNT thick_2 thick_4 thick_6 thick_8 thick_10 thick_12
    
    % MR-Passive NOTE, A and P needs to be reversed
    ens = 'active';
    res = 'MR';
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-thickness-24681012-ens.mat'])
    load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012-ens.mat'])
    if target_year == 2016
        thick_12 = nan(size(thick_4));
        zeta_12 = nan(size(zeta_4)); 
    end
    data.data13 = thick_4;
    data.data14 = thick_8;
    data.data15 = thick_12;
    zeta.data13 = zeta_4;
    zeta.data14 = zeta_8;
    zeta.data15 = zeta_12;
    clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12
    clear COUNT thick_2 thick_4 thick_6 thick_8 thick_10 thick_12
    
    cyl = 1;
    minlon = -98; maxlon=-82; minlat=24; maxlat=30.5;
    figure
    for id_ = 1:15
        eval(['data_=data.data', num2str(id_), ';'])
        eval(['zeta_=zeta.data', num2str(id_), ';'])
        sb(id_) = subplot(5,3,id_); 
        m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
        switch id_
            case 1
                m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                yl(cyl) = ylabel('SP-NoRiver', 'FontName', 'Helvetica', 'FontSize', 15, ...
                    'FontWeight', 'Bold');
                cyl = cyl + 1;
                title(['Apr-', num2str(target_year)], ...
                    'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
            case 2
                m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                title(['Aug-', num2str(target_year)], ...
                    'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
            case 3
                m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                title(['Dec-', num2str(target_year)], ...
                    'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
            case 4
                m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                yl(cyl) = ylabel('SP-Active', 'FontName', 'Helvetica', 'FontSize', 15, ...
                    'FontWeight', 'Bold');
                cyl = cyl + 1;
            case 7
                m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                yl(cyl) = ylabel('SP-Passive', 'FontName', 'Helvetica', 'FontSize', 15, ...
                    'FontWeight', 'Bold');
                cyl = cyl + 1;
            case 10
                m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                yl(cyl) = ylabel('MR-Active', 'FontName', 'Helvetica', 'FontSize', 15, ...
                    'FontWeight', 'Bold');
                cyl = cyl + 1;
            case 13
                m_grid('ytick', 24:2:30, ...
                    'FontName', 'Helvetica', 'FontSize', 14);
                yl(cyl) = ylabel('MR-Passive', 'FontName', 'Helvetica', 'FontSize', 15, ...
                    'FontWeight', 'Bold');
                cyl = cyl + 1;
            case 14
                m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
            case 15
                m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
            otherwise
                m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                    'FontName', 'Helvetica', 'FontSize', 14);
        end
        
        if id_ <= 9
            file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
            grd = load_roms_grid(file_grd_sp);
        else
            file_grd_mr = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
            grd = load_roms_grid(file_grd_mr);
        end
        
        cc_data = data_;
        cc_data(isnan(cc_data)) = 0;
        ccc_data = mean(cc_data, 3);
        ccc_data(ccc_data == 0) = NaN;
        
        hold on
        m_pcolor(grd.lonr, grd.latr, grd.maskr .* ccc_data); shading interp;
        m_gshhs_h('color', 'k');
        m_gshhs('fr', 'color', 'g', 'linewidth', 1)
        
        caxis([0 25])
        colormap(sb(id_), m_colmap('jet', 'step', 12));
        
        if ismember(id_, [9])
            cb = colorbar;
            cb.FontName = 'Helvetica';
            cb.FontSize = 12;
        end

        [cs, h] = m_contour(grd.lonr, grd.latr, nanmean(zeta_,3), [0.17 0.4 0.6], ...
            'color', 'k', 'linewidth', 1.5);
    end

    set(gcf, 'position', [1 -79 1920 1083])

    yl(1).Position(1) = - 0.2;
    yl(2).Position(1) = - 0.2;
    yl(3).Position(1) = - 0.2;
    yl(4).Position(1) = - 0.2;
    yl(5).Position(1) = - 0.2;

    pos = get(sb(2), 'position')
    pos(1) = 0.3;
    set(sb(2), 'position', pos);

    pos = get(sb(3), 'position')
    pos(1) = 0.47;
    set(sb(3), 'position', pos);

    pos = get(sb(4), 'position')
    pos(2) = 0.65;
    set(sb(4), 'position', pos);
    pos = get(sb(5), 'position')
    pos(1) = 0.3;
    pos(2) = 0.65;
    set(sb(5), 'position', pos);
    pos = get(sb(6), 'position')
    pos(1) = 0.47;
    pos(2) = 0.65;
    set(sb(6), 'position', pos);

    pos = get(sb(7), 'position')
    pos(2) = 0.5;
    set(sb(7), 'position', pos);
    pos = get(sb(8), 'position')
    pos(1) = 0.3;
    pos(2) = 0.5;
    set(sb(8), 'position', pos);
    pos = get(sb(9), 'position')
    pos(1) = 0.47;
    pos(2) = 0.5;
    pos(3) = 0.2134;
    set(sb(9), 'position', pos);

    pos = get(sb(10), 'position')
    pos(2) = 0.35;
    set(sb(10), 'position', pos);
    pos = get(sb(11), 'position')
    pos(1) = 0.3;
    pos(2) = 0.35;
    set(sb(11), 'position', pos);
    pos = get(sb(12), 'position')
    pos(1) = 0.47;
    pos(2) = 0.35;
    set(sb(12), 'position', pos);

    pos = get(sb(13), 'position')
    pos(2) = 0.2;
    set(sb(13), 'position', pos);
    pos = get(sb(14), 'position')
    pos(1) = 0.3;
    pos(2) = 0.2;
    set(sb(14), 'position', pos);
    pos = get(sb(15), 'position')
    pos(1) = 0.47;
    pos(2) = 0.2;
    set(sb(15), 'position', pos);
end