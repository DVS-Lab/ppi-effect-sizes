
% load lists from M, T, and S
load('alc2.txt'); % doesn't overlap perfectly with the original (alc.txt)
load('hc2.txt');
load('dep2.txt');

% load sublist from Poldrack 2017 (these have been analyzed/downloaded)
poldrack = load('sublist');

% load other subs who have been analyzed/downloaded)
othersubs = load('newsubs_n116.txt');

% put them together
oldsubs = [poldrack; othersubs];

% get unique subjects
alc_diff = setdiff(alc2,oldsubs);
dlmwrite('alc_diff.txt',alc_diff,'precision','%d')
dep_diff = setdiff(dep2,oldsubs);
dlmwrite('dep_diff.txt',dep_diff,'precision','%d')

% reuse HC subjects and add more to get max n
hc_diff = setdiff(hc2,oldsubs);
hc_int = intersect(hc2,oldsubs);
max_group = length(alc2);
n_needed = max_group - length(hc_int);
hc_new = [hc_int; randsample(hc_diff,n_needed)];
dlmwrite('hc_new.txt',sort(hc_new),'precision','%d')

% make list with all new/needed subs
dlmwrite('all_new_subs.txt',[alc_diff; dep_diff; hc_new],'precision','%d')

