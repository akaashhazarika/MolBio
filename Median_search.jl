function permute(index,arr,last,all_res)
    if index==last
        r = join(arr)
        push!(all_res,r)
    else
        for i in ['A','C','T','G']
            append!(arr,i)
            permute(index+1,arr,last,all_res)
            deleteat!(arr, length(arr)) 
        end
    end
end
        
test = []
permute(0,[],4,test)


function median_string(dna,l,t,n)
    all_res = []
    permute(0,[],l,all_res)
    BestScore = l*t    
    scores = []
    start = []
    best_positions = []
    for i in 1:t
        push!(scores,t)
        push!(start,1)
    end
    median_string = all_res[1]
    
    for permutation in all_res
        scores = []
        start = []
        for i in 1:t
            push!(scores,t)
            push!(start,1)
        end
        for j in 1:t    
            for k in 1:n-l-1
                s1,s2 = 1,k
                mismatches = 0
                for i in 1:l
                    if permutation[s1]!=dna[j][s2]
                        mismatches+=1
                    end
                    s1,s2 = s1+1,s2+1
                end
                if scores[j]>mismatches
                    scores[j] = mismatches
                    start[j] = k
                end
            end
        end
        total_iteration = 0
        for i in 1:t
            total_iteration+=scores[i]
        end
        if total_iteration<BestScore
             BestScore = deepcopy(total_iteration)
             best_positions = deepcopy(start)
             median_string = permutation
        end
    end
    return best_positions,BestScore,median_string
end

position,score,permutation = median_string(["TGGCGTCG","GGCGGGCG","TCTTCGCC","CCCGCTCC"],3,4,8)
        
