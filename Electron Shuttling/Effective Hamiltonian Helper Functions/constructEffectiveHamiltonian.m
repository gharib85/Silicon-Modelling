function Heff = constructEffectiveHamiltonian( sparams, effHamiltonianParams)
%CONSTRUCTEFFECTIVEHAMILTONIAN Summary of this function goes here
%   Detailed explanation goes here
    [epsL, epsR, tc, Ez, Ex, deltaL, deltaR, S1, S2, EL, ER] = decodeEffHamiltonianParamVariable(effHamiltonianParams);
    
    % If we want to include the excited orbital we will ignore all of the
    % other effective hamiltonian parameters (for now... maybe add that
    % functionality in later)
    if sparams.includeExcitedOrbital
        if length(tc) == 1
            HtcMat = [tc, tc, tc, tc];
        else
            HtcMat = [tc(1), tc(3); tc(2), tc(4)];
        end
        HdotL = [epsL, 0; 0, (epsL + EL)];
        HdotR = [epsR, 0; 0, (epsR + ER)];
        
        Heff = kron([1 0;0 0],HdotL) + kron([0 1;0 0],HtcMat') + kron([0 0;1 0],HtcMat) + kron([0 0;0 1],HdotR);
        return;
    end
    
    if sparams.includeOrbital
        Hdet = [epsL 0;0 epsR];
        Htun = [0 tc;tc 0];
        Horbital = Hdet + Htun;
        
        if sparams.includeValley
            Horbital = kron(Horbital,eye(2));
            
            Hvalley = kron([1 0;0 0],[0 deltaL;deltaL' 0]) + kron([0 0;0 1],[0 deltaR;deltaR' 0]);
            
            if sparams.includeSpin
                Horbital = kron(Horbital,eye(2));
                Hvalley = kron(Hvalley,eye(2));
                
                HzeemanZ = [Ez 0;0 -Ez];
                HzeemanZ = kron(eye(4),HzeemanZ);
                
                projL = kron([1 0;0 0],eye(2)); projR = kron([0 0;0 1],eye(2));
                
                HzeemanX = kron(projL,[0 Ex;Ex 0]) + kron(projR,[0 -Ex;-Ex 0]);
                
                HspinOrbit1 = kron(projL,[0 S1;S1 0]) + kron(projR,[0 -S1;-S1 0]);
                HspinOrbit2 = kron(kron([0 1;0 0],eye(2)),[0 S2;0 0]) +...
                    kron(kron([0 0;1 0],eye(2)),[0 0;S2 0]) +...
                    kron(kron([0 0;1 0],eye(2)),[0 -S2;0 0]) +...
                    kron(kron([0 1;0 0],eye(2)),[0 0;-S2 0]);
                
                Heff = Horbital + Hvalley + HzeemanZ + HzeemanX + HspinOrbit1 + HspinOrbit2;
            else
                Heff = Horbital + Hvalley;                
            end
            
        elseif sparams.includeSpin
            Horbital = kron(Horbital,eye(2));

            HzeemanZ = [Ez 0;0 -Ez];
            HzeemanZ = kron(eye(2),HzeemanZ);
            
            projL = [1 0;0 0]; projR = [0 0;0 1];
            
            HzeemanX = kron(projL,[0 Ex;Ex 0]) + kron(projR,[0 -Ex;-Ex 0]);
            
            HspinOrbit1 = kron(projL,[0 S1;S1 0]) + kron(projR,[0 -S1;-S1 0]);
            HspinOrbit2 = kron([0 1;0 0],[0 S2;0 0]) + kron([0 0;1 0],[0 0;S2 0]) +...
                kron([0 0;1 0],[0 -S2;0 0]) + kron([0 1;0 0],[0 0;-S2 0]);
            
            Heff = Horbital + HzeemanZ + HzeemanX + HspinOrbit1 + HspinOrbit2;
        else
            Heff = Horbital;
        end
        
    elseif sparams.includeValley
        Hvalley = [deltaL' 0;0 deltaL];
        
        if sparams.includeSpin
            Hvalley = kron(Hvalley,eye(2));
            
            HzeemanZ = [Ez 0;0 -Ez];
            HzeemanZ = kron(eye(2),HzeemanZ);
            
            HzeemanX = [0 Ex;Ex 0];
            HzeemanX = kron(eye(2),HzeemanX);
            
            Heff = Hvalley + HzeemanZ + HzeemanX;
        else
            Heff = Hvalley;
        end
    elseif sparams.includeSpin
        HzeemanZ = [Ez 0;0 -Ez];
        
        HzeemanX = [0 Ex;Ex 0];
        
        Heff = HzeemanZ + HzeemanX;
    else
        Heff = NaN;
    end
    
    if sparams.includeSecondSpin
        [rows,~] = size(Heff);
        Heff = kron(Heff,eye(2)) + kron(eye(rows),[Ez Ex;Ex -Ez]);
    end
end

