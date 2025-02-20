function init()
    A = FindShape("a")
    B = FindShape("b")
    C = FindShape("c")
    D = FindShape("d")
end   
    
function tick()
    if IsShapeBroken(A) then
        Delete(B)
        Delete(C)
        Delete(D)
    end
end