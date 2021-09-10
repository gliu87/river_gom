%% plot general pattern in 2015, rst data, salt, salt gradient, curlf, stratification
%% note, because of naming systme, sometimes passive and active are in wrong position.

%% step 1, get colormaps
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

load('OMG_CM.mat', 'cm4jet')
colmap2 = [cm4jet(1:8,:); 1,1,1; cm4jet(9:end,:)];

colmap3 = colmap1;
colmap3(1,:) = [1,1,1];

clearvars -except colmap1 colmap2 colmap3

target_years = [2014, 2015, 2016];
resolutions = {'SP', 'MR'};
ens_list = {'passive', 'active', 'noriver'};
ori_time = datenum('2013-1-1');
pm_ = [2,4,6,8,10,12];

ens2014 = {'ens1', 'ens1', 'ens2', 'ens2', 'ens3', 'ens3'};
idx2014 = [12, 23, 11, 23, 11, 24];

ens2015 = {'ens4', 'ens4', 'ens5', 'ens5', 'ens6', 'ens6'};
idx2015 = [12, 23, 11, 24, 11, 24];

ens2016 = {'ens7', 'ens7', 'ens8', 'ens8', 'na', 'na'};
idx2016 = [12, 24, 11, 24, 0, 0];

%% find files and load variables, salt, u, v
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];
file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
grdSP = load_roms_grid(file_grd_sp);

file_grd_mr = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
grdMR = load_roms_grid(file_grd_mr);

minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
ori_time = datenum('2013-01-01');

for yy = 1:3
    
    target_year = target_years(yy);
    if yy == 1
        ensemble_list = ens2014;
        idx_list = idx2014;
    elseif yy == 2
        ensemble_list = ens2015;
        idx_list = idx2015;
    else
        ensemble_list = ens2016;
        idx_list = idx2016;
    end
        
    for rr = 1:2
        res = resolutions{rr};
        for ee = 1:3
            ens = ens_list{ee};
            disp(['processing ', num2str(target_year), ' ', res, ' ', ens])
            if rr == 2 && ee == 3
                continue
            end
            
            for mm = 1:6
                month_ = pm_(mm);
                switch ens
                    case 'passive'
                        tmp_name = [ensemble_list{mm}, '-P-1'];
                    case 'active'
                        tmp_name = [ensemble_list{mm}, '-A-1'];
                    case 'noriver'
                        tmp_name = [ensemble_list{mm}, '-N-1'];
                end
                [path, ~] = find_data_path(tmp_name, res);
                disp(['path ', path])
                if isempty(path)
                    eval(['data.data', num2str((mm-1)*3+1), '=nan(size(grd.lonp));'])
                    eval(['data.data', num2str((mm-1)*3+2), '=nan(size(grd.lonp));'])
                    eval(['data.data', num2str((mm-1)*3+3), '=nan(size(grd.lonp));'])
                    continue
                end
                
                if strcmp(res, 'SP')
                    file = [path, 'GOM', '1km', '_rst.', sprintf('%5.5d', idx_list(mm)), '.nc'];
                    grd = grdSP;
                    file_grd = file_grd_sp;
                else
                    file = [path, 'GOM', '3p5km', '_rst.', sprintf('%5.5d', idx_list(mm)), '.nc'];
                    grd = grdMR;
                    file_grd = file_grd_mr;
                end
                scrum_time = ncread(file, 'scrum_time')/24/3600;
                disp(['Processing Date : ', datestr(ori_time + scrum_time)])
                
                salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
                grad = calc_gradientR(salt, grd.pm, grd.pn);
                grad = rnt_2grid(grad, 'r', 'p');
                u = ncread(file, 'u', [1 1 70 1], [Inf, Inf, 1, 1]);
                v = ncread(file, 'v', [1 1 70 1], [Inf, Inf, 1, 1]);
                [curlf] = calc_vorticity(grd, u, v);
                tindex = 1; coef = 1; vlevl = -10;
                [~,~,~,bvf] = get_bvf(file, file_grd, tindex, vlevl, coef);
                bvf = rnt_2grid(log10(bvf'), 'r', 'p');
                
                eval(['data.data', num2str((mm-1)*3+1), '=grad;'])
                eval(['data.data', num2str((mm-1)*3+2), '=bvf;'])
                eval(['data.data', num2str((mm-1)*3+3), '=curlf;'])
            end
            
            cyl = 1;
            minlon = -98; maxlon=-82; minlat=24; maxlat=30.5;
            figure
            for id_ = 1:18
                eval(['data_=data.data', num2str(id_), ';'])
                sb(id_) = subplot(6,3,id_); 
                m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
                switch id_
                    case 1
                        m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Feb', 'FontName', 'Helvetica', 'FontSize', 13, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                        title('Salinity Gradient', ...
                            'FontName', 'Helvetica', 'FontSize', 13, 'FontWeight', 'Bold')
                    case 2
                        m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        title('Stratification', ...
                            'FontName', 'Helvetica', 'FontSize', 13, 'FontWeight', 'Bold')
                    case 3
                        m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        title('Curl', ...
                            'FontName', 'Helvetica', 'FontSize', 13, 'FontWeight', 'Bold')
                    case 4
                        m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Apr', 'FontName', 'Helvetica', 'FontSize', 13, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                    case 7
                        m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Jun', 'FontName', 'Helvetica', 'FontSize', 13, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                    case 10
                        m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Aug', 'FontName', 'Helvetica', 'FontSize', 15, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                    case 13
                       m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Oct', 'FontName', 'Helvetica', 'FontSize', 13, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                    case 16
                        m_grid('ytick', 24:2:30, ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                        yl(cyl) = ylabel('Dec', 'FontName', 'Helvetica', 'FontSize', 13, ...
                            'FontWeight', 'Bold');
                        cyl = cyl + 1;
                    case 17
                        m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                    case 18
                        m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                    otherwise
                        m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                            'FontName', 'Helvetica', 'FontSize', 13);
                end

                hold on
                m_pcolor(grd.lonp, grd.latp, grd.maskp .* data_); shading interp;
                m_gshhs_h('color', 'k');
                m_gshhs('fr', 'color', 'g', 'linewidth', 1)
                
                
                if ismember(id_, [1, 4, 7, 10, 13, 16])
                    colormap(sb(id_), colmap2(9:end,:))
                    caxis([0, 1e-4])
                elseif ismember(id_, [2, 5, 8, 11, 14, 17])
                    % colormap(sb(id_), colmap3)
                    colormap(sb(id_), jet)
                    caxis([-5.5, -2])
                else
                    colormap(sb(id_), colmap2)
                    caxis([-1, 1])
                end

                if ismember(id_, [16,17,18])
                    cb = colorbar('southoutside');
                    cb.FontName = 'Helvetica';
                    cb.FontSize = 12;
                end
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
            pos(3) = 0.2134;
            set(sb(3), 'position', pos);

            pos = get(sb(5), 'position')
            pos(1) = 0.28;
            set(sb(5), 'position', pos);
            pos = get(sb(6), 'position')
            pos(1) = 0.43;
            pos(3) = 0.2134;
            set(sb(6), 'position', pos);

            pos = get(sb(8), 'position')
            pos(1) = 0.28;
            set(sb(8), 'position', pos);
            pos = get(sb(9), 'position')
            pos(1) = 0.43;
            pos(3) = 0.2134;
            set(sb(9), 'position', pos);

            pos = get(sb(11), 'position')
            pos(1) = 0.28;
            set(sb(11), 'position', pos);
            pos = get(sb(12), 'position')
            pos(1) = 0.43;
            pos(3) = 0.2134;
            set(sb(12), 'position', pos);

            pos = get(sb(14), 'position')
            pos(1) = 0.28;
            set(sb(14), 'position', pos);
            pos = get(sb(15), 'position')
            pos(1) = 0.43;
            pos(3) = 0.2134;
            set(sb(15), 'position', pos);
            
            pos = get(sb(16), 'position')
            pos(4) = 0.1026;
            pos(2) = 0.11;
            set(sb(16), 'position', pos);
            pos = get(sb(17), 'position')
            pos(1) = 0.28;
            set(sb(17), 'position', pos);
            pos = get(sb(18), 'position')
            pos(1) = 0.43;
            pos(3) = 0.2134;
            set(sb(18), 'position', pos);
            
            %% save
            clear data
        end
        
    end
end


