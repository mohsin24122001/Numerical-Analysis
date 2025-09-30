function f = facto(n)
        if ~isscalar(n) || n ~= fix(n) || n<0
            error('non negative integer scalar expected ')
        end
        if n == 0
            f=1;
        else
            f = n* facto(n-1);
        end
end