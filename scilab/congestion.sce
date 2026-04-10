function G = adj_mat(n)
    G = grand(n, n, "uin", 1, 10);
    
    for i = 1:n
        for j = 1:n
            if rand() > 0.7 then
                G(i,j) = 0;
            end
        end
        G(i,i) = 0;
    end
endfunction

function load = congestion_control(G)
    n = size(G,1);
    load = zeros(1,n);
    
    for i = 1:n
        for j = 1:n
            if G(i,j) > 0 then
                load(i) = load(i) + G(i,j);
            end
        end
    end
endfunction

G200 = adj_mat(200);
G300 = adj_mat(300);

// Timing
tic();
congestion_control(G200);
time200 = toc();

tic();
congestion_control(G300);
time300 = toc();

// Plot
nodes1 = [200 300];
time1 = [time200 time300];

clf();
plot(nodes1, time1, '-r');
xlabel("Nodes");
ylabel("Time");
title("Congestion Control (200 vs 300)");
xgrid();

// Create 5 different networks
G1 = adj_mat(500);
G2 = adj_mat(500);
G3 = adj_mat(500);
G4 = adj_mat(500);
G5 = adj_mat(500);

sizes = [500 400 300 200 100];
time_all = zeros(5, length(sizes));

// Loop through methods
for m = 1:5
    
    if m == 1 then G = G1;
    elseif m == 2 then G = G2;
    elseif m == 3 then G = G3;
    elseif m == 4 then G = G4;
    else G = G5;
    end
    
    // Reduce size
    for i = 1:length(sizes)
        n = sizes(i);
        G_sub = G(1:n,1:n);
        
        tic();
        congestion_control(G_sub);
        time_all(m,i) = toc();
    end
end

// Plot all methods
clf();
for m = 1:5
    plot(sizes, time_all(m,:), '-');
end

xlabel("Nodes");
ylabel("Time");
title("Congestion Control for Different Networks");
legend("Method1","Method2","Method3","Method4","Method5");
xgrid();
