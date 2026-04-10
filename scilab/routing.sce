// Adjacency Matrix
function G = adj_mat(n)
    G = grand(n, n, "uin", 1, 10);
    
    // Make graph sparse
    for i = 1:n
        for j = 1:n
            if rand() > 0.7 then
                G(i,j) = 0;
            end
        end
        G(i,i) = 0;
    end
endfunction

// Dijkstra Algorithm
function dist = dijkstra(G, src)
    n = size(G,1);
    dist = ones(1,n) * %inf;
    visited = zeros(1,n);
    dist(src) = 0;

    for i = 1:n
        [m,u] = min(dist + visited * max(dist) * 2);
        visited(u) = 1;

        for v = 1:n
            if G(u,v) > 0 & visited(v) == 0 then
                if dist(u) + G(u,v) < dist(v) then
                    dist(v) = dist(u) + G(u,v);
                end
            end
        end
    end
endfunction

// Bellman-Ford Algorithm
function dist = bellman_ford(G, src)
    n = size(G,1);
    dist = ones(1,n) * %inf;
    dist(src) = 0;

    for k = 1:n-1
        for u = 1:n
            for v = 1:n
                if G(u,v) > 0 then
                    if dist(u) + G(u,v) < dist(v) then
                        dist(v) = dist(u) + G(u,v);
                    end
                end
            end
        end
    end
endfunction

nodes = 5:5:100;
time_dijkstra = [];
time_bellman = [];

for n = nodes
    
    G = adj_mat(n);
    
    // -------- Dijkstra Timing --------
    tic();
    dijkstra(G, 1);
    time_dijkstra($+1) = toc();
    
    // -------- Bellman-Ford Timing --------
    tic();
    bellman_ford(G, 1);
    time_bellman($+1) = toc();
    
end

clf();

// Plot Dijkstra (RED)
plot(nodes, time_dijkstra, '-r');

// Plot Bellman-Ford (BLUE)
plot(nodes, time_bellman, '-b');

xlabel("Number of Nodes");
ylabel("Execution Time (seconds)");
title("Routing Algorithm Comparison");
legend("Dijkstra", "Bellman-Ford");
xgrid();
