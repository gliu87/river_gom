%%  section plot passive and active cases
%% note, because of naming systme, sometimes passive and active are in wrong position.
warning('off', 'all')
out_dir = 'H:/GoM_Transport/';
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];
file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
grd = load_roms_grid(file_grd_sp);
gname = file_grd_sp;

target_year = 2015;
sects = [26, 27, 28];

mon = 6;

for ii = 1:3
    sect = sects(ii);
    [data_path_active, ~] = find_data_path('ens5-P-1', 'SP');
    [data_path_passive, ~] = find_data_path('ens5-A-1', 'SP');
    
    avg1 = ls([data_path_active, '*_avg*']);
    avg2 = ls([data_path_passive, '*_avg*']);
    for nn = 0:min(length(avg1)-1, length(avg2)-1)
        file_out1 = [out_dir, 'transport_', 'ens5-P-1', '_avg_', sprintf('%5.5d', nn), '.nc'];
        file_out2 = [out_dir, 'transport_', 'ens5-A-1', '_avg_', sprintf('%5.5d', nn), '.nc'];
        file_dens1 = [data_path_active, 'GOM1km_avg.', sprintf('%5.5d', nn), '.nc'];
        file_dens2 = [data_path_passive, 'GOM1km_avg.', sprintf('%5.5d', nn), '.nc'];
        time_ = ncread(file_out1, 'time');
        disp(datestr(time_))
        if year(time_) == target_year && (month(time_) == mon)
            trans1 = ncread(file_out1, 'trans_v');
            trans2 = ncread(file_out2, 'trans_v');
            [~,~,~,h]=get_z_sig26(file_dens1,gname,1,1);
            rho261 = h'; clear h
            [~,~,~,h]=get_z_sig26(file_dens2,gname,1,1);
            rho262 = h'; clear h

            if exist(['rho261_', num2str(floor(sect))], 'var')
                var_r1 = ['rho261_', num2str(floor(sect))];
                eval([var_r1, '=cat(3,', var_r1, ',rho261);'])
            else
                var_r1 = ['rho261_', num2str(floor(sect))];
                eval([var_r1, '=rho261;'])
            end
            
            if exist(['rho262_', num2str(floor(sect))], 'var')
                var_r2 = ['rho262_', num2str(floor(sect))];
                eval([var_r2, '=cat(3,', var_r2, ',rho262);'])
            else
                var_r2 = ['rho262_', num2str(floor(sect))];
                eval([var_r2, '=rho262;'])
            end 
            
            [~, bidx] = min(abs(grd.latp(1,:) - sect));
            tmp=squeeze(trans1(:,bidx,:));
            if exist(['trans1_', num2str(floor(sect)), '_sect'], 'var')
                var_ = ['trans1_', num2str(floor(sect)), '_sect'];
                eval([var_, '=cat(3,', var_, ',tmp);'])
            else
                var_ = ['trans1_', num2str(floor(sect)), '_sect'];
                eval([var_, '=tmp;'])
            end
            clear tmp var_
            
            tmp=squeeze(trans2(:,bidx,:));
            if exist(['trans2_', num2str(floor(sect)), '_sect'], 'var')
                var_ = ['trans2_', num2str(floor(sect)), '_sect'];
                eval([var_, '=cat(3,', var_, ',tmp);'])
            else
                var_ = ['trans2_', num2str(floor(sect)), '_sect'];
                eval([var_, '=tmp;'])
            end
            clear tmp var_
            
        end
    end
end

load('OMG_CM.mat')
cm4jet_ = cm4jet;
cm4jet = [cm4jet(1:8,:); [1 1 1]; cm4jet(9:16,:)];  

LON = repmat(grd.lonp(:,1), [1, 70]);
DIR = 'F:\Dropbox (GaTech)\EAS-Bracco-TEAM\dsun42\croco_output\GOM_hycom\';
backfile = [DIR, '1km_bulk_nor\output_201508_201512\GOM1km_avg.00015.nc'];
[zr_] = get_depths(backfile, file_grd_sp, 1, 'r');
zr = permute(zr_, [3, 2, 1]);
zrp = rnt_2grid(zr, 'r', 'p');


figure
sb(1)=subplot(3,3,1)
[~, bidx] = min(abs(grd.latp(1,:) - 26));
ZR = squeeze(zrp(:,bidx,:));
data = nanmean(trans1_26_sect,3);
rho_ = nanmean(rho261_26,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
title(['active'])
yl(1) = ylabel('26N');
xticklabels([])
box on

sb(2)=subplot(3,3,2)
data = nanmean(trans2_26_sect,3);
rho_ = nanmean(rho262_26,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
title(['passive'])
xticklabels([])
yticklabels([])
box on

sb(3)=subplot(3,3,3)
data = nanmean(trans1_26_sect - trans2_26_sect,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
title(['active - passive'])
xticklabels([])
yticklabels([])
box on

sb(4)=subplot(3,3,4)
[~, bidx] = min(abs(grd.latp(1,:) - 27));
ZR = squeeze(zrp(:,bidx,:));
data = nanmean(trans1_27_sect,3);
rho_ = nanmean(rho261_27,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
yl(2) = ylabel('27N');
xticklabels([])
box on

sb(5)=subplot(3,3,5)
data = nanmean(trans2_27_sect,3);
rho_ = nanmean(rho262_27,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
xticklabels([])
yticklabels([])
box on

sb(6)=subplot(3,3,6)
data = nanmean(trans1_27_sect - trans2_27_sect,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
xticklabels([])
yticklabels([])
box on
colorbar

sb(7)=subplot(3,3,7)
[~, bidx] = min(abs(grd.latp(1,:) - 28));
ZR = squeeze(zrp(:,bidx,:));
data = nanmean(trans1_28_sect,3);
rho_ = nanmean(rho261_28,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
yl(3) = ylabel('28N');
box on

sb(8)=subplot(3,3,8)
data = nanmean(trans2_28_sect,3);
rho_ = nanmean(rho262_28,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonr(:,1), rho_(:,bidx), 'k-')
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
yticklabels([])
box on

sb(9)=subplot(3,3,9)
data = nanmean(trans1_28_sect - trans2_28_sect,3);
pcolor(LON, ZR, data); shading interp
hold on
plot(grd.lonp(:,1), ZR(:,1), 'b-')
colormap(cm4jet);
caxis([-2 2])
ylim([-800, 0])
yticklabels([])
box on

set(gcf, 'position', [1,41,1920,1083])

pos = get(sb(1), 'position')
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(1), 'position', pos)
pos = get(sb(2), 'position')
pos(1) = 0.3;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(2), 'position', pos)
pos = get(sb(3), 'position')
pos(1) = 0.47;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(3), 'position', pos)

pos = get(sb(4), 'position')
pos(2) = 0.53;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(4), 'position', pos)
pos = get(sb(5), 'position')
pos(1) = 0.3;
pos(2) = 0.53;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(5), 'position', pos)
pos = get(sb(6), 'position')
pos(1) = 0.47;
pos(2) = 0.53;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(6), 'position', pos)

pos = get(sb(7), 'position')
pos(2) = 0.35;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(7), 'position', pos)
pos = get(sb(8), 'position')
pos(1) = 0.3;
pos(2) = 0.35;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(8), 'position', pos)
pos = get(sb(9), 'position')
pos(1) = 0.47;
pos(2) = 0.35;
pos(3) = 0.16;
pos(4) = 0.1577;
set(sb(9), 'position', pos)
