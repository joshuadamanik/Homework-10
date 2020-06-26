function [A, B, R] = cost_function_param(N, X0)
    
    %syms h
    h = 20 / N;
    
    %%
    A11 = zeros(N, N);
    A11(1,1) = 6;
    for i = 2:N
        A11(i,i) = 6;
        A11(i,i-1) = -6;
    end
    
    A12 = zeros(N, N);
    A12(1,1) = -3*h;
    for i = 2:N
        A12(i,i) = -3*h;
        A12(i,i-1) = -3*h;
    end
    
    A13 = zeros(N, N);
    for i = 1:N-1
        A13(i,i+1) = h.^2/2;
        A13(i,i) = -h.^2/2;
    end
    A13(N,N) = -h.^2/2;
    
    A1 = [A11, A12, A13];
    
    %%
    A21 = zeros(N,N);
    A22 = zeros(N, N);
    A22(1,1) = 6;
    for i = 2:N-1
        A22(i,i) = 6;
        A22(i,i-1) = -6;
    end
    A22(N,N) = 1;
    A22(N,N-1) = -1;
    
    A23 = zeros(N, N);
    for i = 1:N-1
        A23(i,i+1) = -3*h;
        A23(i,i) = -3*h;
    end
    A23(N,N) = -h;
    
    A2 = [A21, A22, A23];
    
    A = [A1; A2];
    
    
    
    %%
    B1 = zeros(N,1);
    B1(1) = 6*X0(1) + 3*h*X0(2);
    
    B2 = zeros(N,1);
    B2(1) = 6*X0(2);
    B = [B1;B2];
    
    
    %%
    R = blkdiag(zeros(2*N),eye(N));
    
    %%
    A = [A; zeros(1,N-1), 1, zeros(1,2*N)];% zeros(1,2*N-1), 1, zeros(1,N)];
    B = [B; 0];% 0];
end

% function [A, B, R] = cost_function_param(N, X0)
%     dt = 20 / N;
%     
%     A11 = eye(N) - diag(ones(N-1,1),-1);
%     A12 = -dt*diag(ones(N-1,1),-1);
%     A13 = zeros(N);
%     A1 = [A11, A12, A13];
%     
%     A21 = A13;
%     A22 = A11;
%     A23 = -dt*eye(N);
%     A2 = [A21, A22, A23];
%     
%     A3 = [zeros(1, N-1), 1, zeros(1, 2*N)];
%     A4 = [zeros(1, 2*N-1), 1, zeros(1, N)];
%     
%     A = [A1; A2; A3];%; A4];
%     
%     B1 = [X0(1)-X0(2)*dt; zeros(N-1,1)];
%     B2 = [X0(2); zeros(N-1,1)];
%     B3 = 0;
%     B4 = 0;
%     
%     B = [B1; B2; B3];%; B4];
%     
%     
%     R = blkdiag(zeros(2*N),eye(N));
% end