%warning('off', 'all')
%% note, because of naming systme, sometimes passive and active are in wrong position.
tic;
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];

%% load zr information
DIR = 'F:\Dropbox (GaTech)\EAS-Bracco-TEAM\dsun42\croco_output\GOM_hycom\';
importfile('Capture.PNG');
rr = cdata(:,15,1);
gg = cdata(:,15,2);
bb = cdata(:,15,3);
cmap = [double(rr(3:end-2))/255, double(gg(3:end-2))/255, double(bb(3:end-2))/255];
cmap = flipud(cmap);
x1 = 1:1:length(cmap);
x2 = 1:(length(cmap)-1)/55:length(cmap);
colmap1 = [interp1(x1', cmap(:,1), x2'), interp1(x1', cmap(:,2), x2'), ...
    interp1(x1', cmap(:,3), x2')];

ori_time = datenum('2013-1-1');
ens_list = {'passive', 'active', 'noriver'};
resolutions = {'SP', 'MR'};

for rr = 1:2
    res = resolutions{rr};
    switch res
        case 'SP'
            file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
            grd = load_roms_grid(file_grd_sp);
            gname = file_grd_sp;
        case 'MR'
            file_grd_sp = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
            grd = load_roms_grid(file_grd_sp);
            gname = file_grd_sp;
    end
    for ee = 1:3
        ens = ens_list{ee};
        
        if rr == 2 && ee == 3
            continue
        end

        target_year = 2014;
        load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012.mat'])
        data.data1 = salt_2;
        data.data4 = salt_4;
        data.data7 = salt_6;
        data.data10 = salt_8;
        data.data13 = salt_10;
        data.data16 = salt_12;

        zeta.data1 = zeta_2;
        zeta.data4 = zeta_4;
        zeta.data7 = zeta_6;
        zeta.data10 = zeta_8;
        zeta.data13 = zeta_10;
        zeta.data16 = zeta_12;
        clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12


        target_year = 2015;
        load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012.mat'])
        data.data2 = salt_2;
        data.data5 = salt_4;
        data.data8 = salt_6;
        data.data11 = salt_8;
        data.data14 = salt_10;
        data.data17 = salt_12;

        zeta.data2 = zeta_2;
        zeta.data5 = zeta_4;
        zeta.data8 = zeta_6;
        zeta.data11 = zeta_8;
        zeta.data14 = zeta_10;
        zeta.data17 = zeta_12;
        clear salt_2 salt_4 salt_6 salt_8 salt_10 salt_12 zeta_2 zeta_4 zeta_6 zeta_8 zeta_10 zeta_12

        target_year = 2016;
        load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                        ens, '-', res, '-', num2str(target_year), '-mean-saltzeta-24681012.mat'])
        data.data3 = salt_2;
        data.data6 = salt_4;
        data.data9 = salt_6;
        data.data12 = salt_8;
        data.data15 = nan(size(salt_2));
        data.data18 = nan(size(salt_2));

        zeta.data3 = zeta_2;
        zeta.data6 = zeta_4;
        zeta.data9 = zeta_6;
        zeta.data12 = zeta_8;
        zeta.data15 = nan(size(salt_2));
        zeta.data18 = nan(size(salt_2));
        clear salt_2 salt_4 salt_6 salt_8 zeta_2 zeta_4 zeta_6 zeta_8 

        cyl = 1;
        minlon = -98; maxlon=-82; minlat=24; maxlat=30.5;
        figure
        for id_ = 1:18
            eval(['data_=data.data', num2str(id_), ';'])
            eval(['zeta_=zeta.data', num2str(id_), ';'])
            sb(id_) = subplot(6,3,id_); 
            m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
            switch id_
                case 1
                    m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Feb', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                    title('2014', ...
                        'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
                case 2
                    m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    title('2015', ...
                        'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
                case 3
                    m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    title('2016', ...
                        'FontName', 'Helvetica', 'FontSize', 15, 'FontWeight', 'Bold')
                case 4
                    m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Apr', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                case 7
                    m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Jun', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                case 10
                    m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Aug', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                case 13
                   m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Oct', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                case 16
                    m_grid('ytick', 24:2:30, ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                    yl(cyl) = ylabel('Dec', 'FontName', 'Helvetica', 'FontSize', 15, ...
                        'FontWeight', 'Bold');
                    cyl = cyl + 1;
                case 17
                    m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                case 18
                    m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
                otherwise
                    m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                        'FontName', 'Helvetica', 'FontSize', 14);
            end

            hold on
            m_pcolor(grd.lonr, grd.latr, grd.maskr .* nanmean(data_,3)); shading interp;
            m_gshhs_h('color', 'k');
            m_gshhs('fr', 'color', 'g', 'linewidth', 1)

            colormap(sb(id_), colmap1)
            caxis([26, 38])
            if ismember(id_, [3,6,9,12,15,18])
                cb = colorbar;
                cb.FontName = 'Helvetica';
                cb.FontSize = 12;
            end

            [cs, h] = m_contour(grd.lonr, grd.latr, nanmean(zeta_,3), [0.17 0.17], ...
                'color', 'k', 'linewidth', 1.5);
        end

        set(gcf, 'position', [1 41 1920 1083])

        yl(1).Position(1) = - 0.2;
        yl(2).Position(1) = - 0.2;
        yl(3).Position(1) = - 0.2;
        yl(4).Position(1) = - 0.2;
        yl(5).Position(1) = - 0.2;
        yl(6).Position(1) = - 0.2;

        pos = get(sb(2), 'position')
        pos(1) = 0.28;
        set(sb(2), 'position', pos);

        pos = get(sb(3), 'position')
        pos(1) = 0.43;
        set(sb(3), 'position', pos);

        pos = get(sb(5), 'position')
        pos(1) = 0.28;
        set(sb(5), 'position', pos);
        pos = get(sb(6), 'position')
        pos(1) = 0.43;
        set(sb(6), 'position', pos);

        pos = get(sb(8), 'position')
        pos(1) = 0.28;
        set(sb(8), 'position', pos);
        pos = get(sb(9), 'position')
        pos(1) = 0.43;
        set(sb(9), 'position', pos);

        pos = get(sb(11), 'position')
        pos(1) = 0.28;
        set(sb(11), 'position', pos);
        pos = get(sb(12), 'position')
        pos(1) = 0.43;
        set(sb(12), 'position', pos);

        pos = get(sb(14), 'position')
        pos(1) = 0.28;
        set(sb(14), 'position', pos);
        pos = get(sb(15), 'position')
        pos(1) = 0.43;
        set(sb(15), 'position', pos);

        pos = get(sb(17), 'position')
        pos(1) = 0.28;
        set(sb(17), 'position', pos);
        pos = get(sb(18), 'position')
        pos(1) = 0.43;
        set(sb(18), 'position', pos);

    end
end
