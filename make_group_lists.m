
% load lists from M, T, and S
load('alc.txt');
load('hc.txt');
load('dep.txt');

% load sublist from Poldrack 2017 (these have been analyzed/downloaded, save for gambling)
poldrack = load('sublist');

% get unique subjects
alc_diff = setdiff(alc,poldrack);
dlmwrite('alc_diff.txt',alc_diff,'precision','%d')
dep_diff = setdiff(dep,poldrack);
dlmwrite('dep_diff.txt',dep_diff,'precision','%d')

% reuse HC subjects and add more to get 60
hc_diff = setdiff(hc,poldrack);
hc_int = intersect(hc,poldrack);
max_group = length(alc);
n_needed = max_group - length(hc_int);
hc_subs = [hc_int; randsample(hc_diff,n_needed)];
dlmwrite('hc_n60.txt',sort(hc_subs),'precision','%d')

