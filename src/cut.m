function mask = cut(bndcost)

[h, w, dim] = size(bndcost);

dp = zeros(h + 2, w);
from = zeros(h + 2, w);
mask = zeros(h, w);

dp(1, :) = Inf * ones(1, w);
dp(h+2, :) = Inf * ones(1, w);

for i = 2:h+1
    dp(i, 1) = sum(bndcost(i - 1, 1, :));
end

for j = 2:w
    for i = 2:h+1
        if dp(i, j - 1) <= dp(i - 1, j - 1) && dp(i, j - 1) <= dp(i + 1, j - 1)
            dp(i, j) = dp(i, j - 1) + sum(bndcost(i - 1, j, :));
            from(i, j) = 2;
        elseif dp(i - 1, j - 1) <= dp(i, j - 1) && dp(i - 1, j - 1) <= dp(i + 1, j - 1)
            dp(i, j) = dp(i - 1, j - 1) + sum(bndcost(i - 1, j, :));
            from(i, j) = 1;
        else 
            dp(i, j) = dp(i + 1, j - 1) + sum(bndcost(i - 1, j, :));
            from(i, j) = 3;
        end
    end
end

idx = 2;
for i = 2:h+1
    if dp(idx, w) >= dp(i, w)
        idx = i;
    end
end

for j = w:-1:1
    mask(1:idx-1, j) = ones(idx-1, 1);
    if from(idx, j) == 1
        idx = idx - 1;
    elseif from(idx, j) == 3
        idx = idx + 1;
    end
end