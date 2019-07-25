function ExtractMthEnd(Dtd)
    data = Dtd["A1:C104"] #load all data
    date = Dtd["B1:B104"] #load date notice dates are in numerical format

    ndate = length(date)
    mm = zeros(ndate,1) #save month
    for i = 1:ndate
        mm[i] = trunc(date[i]/100)
    end

    global ind = [] #save index of end of each month
    for i = 1:ndate-1
        if mm[i] != mm[i+1]
            global ind = [ind;i]
        end
    end
    global ind = [ind;ndate]

    enddate = data[ind,2] #last day of each month
    stind = ind+ones(length(ind))
    stind = convert(Array{Int8,1},stind[1:length(ind)-1])
    stind = [1;stind] #save index of start of each month
    strdate = data[stind,2] #first day of each month

    mend = data[ind,:] #monthly end data

    while prod(ind-ones(length(ind)))>0 #loop until first day of each month
        for i = 1:length(ind)
            if mend[i,3] == "NaN"
                temp = ind[i]-1 #instead of the previous day
                mend[i,3] = data[temp,3] #update Dtd
                ind[i] = temp #update ind
            end
        end
    end

    mend[:,2] = data[ind,2] #update date

    for i = 1:length(ind) #check if all NaN
        if mend[i,2] == strdate[i]
            mend[i,2] = enddate[i] #update date
        end
    end

    return mend
end
