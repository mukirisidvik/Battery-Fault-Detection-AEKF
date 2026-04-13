function fault = fault_isolation(d_umax, d_umin, d_ui)
if d_umax && d_umin
    fault = 2;   % current sensor fault
elseif d_umax
    fault = 3;   % voltage sensor fault (max cell)
elseif d_umin
    fault = 4;   % voltage sensor fault (min cell)
else
    fault = 0;   % healthy
end
end
